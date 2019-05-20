# install.packages(c("readr", "bsts", "tidyverse", "coda", "doFuture"))

library(readr)
library(bsts)
library(tidyverse)
library(coda)
library(doFuture)

loc_ids <- c(
  "1",
  "2",
  "3",
  "4",
  "5",
  "6",
  "7",
  "8",
  "9",
  "10",
  "11",
  "12",
  "13",
  "14",
  "15",
  "16",
  "17",
  "18",
  "19"
)

dataset <-
  read_csv(
    "../data/mc1-reports-data.csv",
    col_types = cols(
      buildings = col_number(),
      medical = col_number(),
      power = col_number(),
      roads_and_bridges = col_number(),
      sewer_and_water = col_number(),
      shake_intensity = col_number(),
      time = col_datetime(format = "%Y-%m-%d %H:%M:%S"),
      location = col_factor(levels = loc_ids)
    )
  )


run_bsts <-
  function(data,
           loc,
           cat,
           time_end,
           plot_bsts = F,
           out_dir = "") {
    dataset_filtered <- dataset %>%
      dplyr::filter(location == loc) %>%
      drop_na(cat) %>%
      arrange(time) %>%
      dplyr::filter(time <= time_end)
    
    stopifnot(dim(dataset_filtered)[1] >= 5)
    
    # y = log(dataset_filtered[[cat]] + 0.1)
    y = dataset_filtered[[cat]]
    
    sdy <- sd(as.numeric(y), na.rm = TRUE)
    initial.y <- y[1]
    
    small_sigma_prior <- SdPrior(0.1 * sdy, upper.limit = 0.5 * sdy)
    large_sigma_prior <- SdPrior(0.5 * sdy, upper.limit = 2 * sdy)
  
    ss <- AddLocalLevel(list(), y)
    # ss <- AddLocalLevel(ss, y, SdPrior(sdy, upper.limit = 3 * sdy), NormalPrior(initial.y, 3 * sdy))
    # ss <- AddLocalLevel(list(), y, sigma_prior, NormalPrior(initial.y, 0.5 * sdy))
    
    #ss <- AddLocalLinearTrend(list(), y)
    #ss <- AddLocalLinearTrend(list(), y, level.sigma.prior = large_sigma_prior, slope.sigma.prior = small_sigma_prior)
    
    # ss <- AddLocalLinearTrend(list(), y,  SdPrior(sdy, upper.limit = sdy), SdPrior(sdy, upper.limit = sdy), NormalPrior(initial.y, 3 * sdy))
    # ss <- AddStudentLocalLinearTrend(list(), y)
    
    model <-
      bsts(
        y,
        ss,
        niter = 300,
        # ping = 0,
        timestamps = dataset_filtered$time,
        seed = 0,
        family = 'poisson'
      )
    
    if (plot_bsts == T) {
      plot(model, scale = "mean", ylim = c(0, 10))
    }
    
    burn = 100
    state <- model$state.contributions
    state <- state[-(1:burn), , , drop = FALSE]
    state <- rowSums(aperm(state, c(1, 3, 2)), dims = 2)
    if (model$family == "poisson") {
      # state <- t(t(exp(state)) * model$exposure)
      state <- exp(state)
    }
    
    means <- colMeans(state)
    
    modes <- rowMeans(HPDinterval(as.mcmc(state), prob = 0.0))
    
    hdi95 <- HPDinterval(as.mcmc(state), prob = 0.95)
    hdi90 <- HPDinterval(as.mcmc(state), prob = 0.9)
    hdi80 <- HPDinterval(as.mcmc(state), prob = 0.8)
    hdi50 <- HPDinterval(as.mcmc(state), prob = 0.5)
    
    quantile.step <- .025
    qtl <- seq(0, 1, by = quantile.step)
    quantile.matrix <-
      t(apply(state, 2, quantile, probs = qtl, na.rm = TRUE))
    
    time_min <- min(dataset_filtered$time)
    time_max <- max(dataset_filtered$time)
    
    time_points <- seq(time_min, time_max, by = "5 min")
    
    mcmc_results <-
      tibble(
        cat = cat,
        loc = loc,
        time = time_points,
        mcmc = t(state)
      )
    
    mcmc_summary <-
      tibble(
        cat = cat,
        loc = loc,
        time = time_points,
        mean = means,
        mode = modes,
        hdi95 = hdi95,
        hdi90 = hdi90,
        hdi80 = hdi80,
        hdi50 = hdi50,
        q = quantile.matrix
      )
    
    
    if (out_dir != "") {
      if (!dir.exists(out_dir)) {
        dir.create(out_dir)
        dir.create(paste(out_dir, "summary", sep = "/"))
      }
      
      # out_file = gzfile(paste(out_dir, "/", format(time_end,"%Y-%m-%d_%H-%M-%OS"), ".csv.gz", sep = ""),
      #                  compression = 9)
      # out_file = paste(out_dir, "/", format(time_end,"%Y-%m-%d_%H-%M-%OS"), ".csv", sep="")
      
      # write.csv(mcmc_results,
      #           out_file,
      #           quote = F,
      #           row.names = F)
      
      
      out_summary = paste(
        out_dir,
        "/summary/summary-",
        format(time_end, "%Y-%m-%d_%H-%M-%OS"),
        ".csv",
        sep =
          ""
      )
      
      write.csv(mcmc_summary,
                out_summary,
                quote = F,
                row.names = F)
    }
    
    return (list(mcmc_results = mcmc_results, mcmc_summary = mcmc_summary))
  }

loc = "1"
cat = "buildings"
time_end <- as.POSIXct("2020-04-12 13:00:00", tz = "UTC")
run_bsts(dataset, loc, cat, time_end, plot_bsts = T)

run_parallel <- function(pop, fun) {
  registerDoFuture()
  cl <- parallel::makeCluster(availableCores() - 1)
  # cl <- parallel::makeCluster(8)
  old_plan <- plan(cluster, workers = cl)
  on.exit({
    plan(old_plan)
    parallel::stopCluster(cl)
  })
  
  foreach(i = pop,
          .verbose = TRUE,
          .errorhandling = "remove") %dopar% fun(i)
}

categories = c(
  "shake_intensity",
  "buildings",
  "medical",
  "power",
  "roads_and_bridges",
  "sewer_and_water"
)

i <- 0
time_start_loop <- Sys.time()

for (loc in loc_ids[1]) {
  for (cat in categories[2]) {
    #loc <- "1"
    #cat <- "buildings"
    
    print(loc)
    print(cat)
    
    ## All time points
    # time_min <- min(dataset$time)
    # time_max <- max(dataset$time)
    # time_points <- seq(time_min, time_max, by = "5 min")
    
    ## Only time points with data
    time_points <- sort(unique(
      dataset %>%
        dplyr::filter(location == loc) %>%
        drop_na(cat) %>%
        pull(time)
    ))
    
    
    dir.create(paste(".", "out", sep = "/"))
    dir.create(paste(".", "out", loc, sep = "/"))
    
    out_dir <- paste(".", "out", loc, cat, sep = "/")
    
    run_bsts_end <- function(end) {
      mcmc <- run_bsts(
        data = dataset,
        loc = loc,
        cat = cat,
        time_end = end,
        out_dir = out_dir
      )
      
      last_result <- tail(mcmc$mcmc_results, 1)
      last_summary <- tail(mcmc$mcmc_summary, 1)
      
      last_result$time_end <- end
      last_summary$time_end <- end
      
      out_results_file <-
        paste("./out/", cat, "_results.csv", sep = "")
      out_summary_file <-
        paste("./out/", cat, "_summary.csv", sep = "")
      
      if (file.exists(out_results_file)) {
        write.table(
          last_result,
          out_results_file,
          append = T,
          quote = F,
          sep = ",",
          row.names = F,
          col.names = F
        )
      } else {
        write.table(
          last_result,
          out_results_file,
          append = T,
          quote = F,
          sep = ",",
          row.names = F,
          col.names = T
        )
      }
      
      if (file.exists(out_summary_file)) {
        write.table(
          last_summary,
          out_summary_file,
          append = T,
          quote = F,
          sep = ",",
          row.names = F,
          col.names = F
        )
      } else {
        write.table(
          last_summary,
          out_summary_file,
          append = T,
          quote = F,
          sep = ",",
          row.names = F,
          col.names = T
        )
      }
    }
    
    
    #time_end <- as.POSIXct("2020-04-07 13:00:00", tz = "UTC")
    #run_bsts_end(time_end)
    #run_bsts_end(time_end + 60000)
    
    time_start <- Sys.time()
    
    run_parallel(time_points, run_bsts_end)
    
    time_end <- Sys.time()
    
    print("Time used in this loop")
    print(time_end - time_start)
    
    i <- i + 1
    print("Time elapsed")
    print(time_end - time_start_loop)
    
    print("Average time per loop")
    print((time_end - time_start_loop) / i)
    
    
  }
}
