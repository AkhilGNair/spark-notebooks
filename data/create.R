library(tidyverse)
library(arrow)


set.seed(5432)

N_USERS = 1000000
N_OBS = 1000
M = 10000
N_PARTITIONS = 20

user_ids = unique(floor(runif(N_USERS, M, 10*M)))
vals = lapply(user_ids, function(i) { floor(runif(N_OBS, 1, 1000)) })

deltas = runif(length(user_ids) * N_OBS, 1, 60 * 60 * 24)
timestamps = strptime(c("2022-03-09 10:07:52"), "%Y-%m-%d %H:%M:%S") + deltas

df = tibble(user_id = user_ids, values = vals) %>%
  unnest(values) %>%
  mutate(
    user_id = as.integer(user_id),
    value = values,
    timestamp = timestamps,
    partition = user_id %% N_PARTITIONS
  ) %>%
  select(-values) %>%
  group_by(partition)

path = file.path("data", "users.parquet")
dir.create(path, showWarnings = FALSE)
write_dataset(df, path=path, format = "parquet")
