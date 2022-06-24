# Fake Data

## Installing Arrow on Ubuntu

In a terminal, install the `arrow` dependencies

```{bash}
sudo apt update
sudo apt install -y -V ca-certificates lsb-release wget
wget https://apache.jfrog.io/artifactory/arrow/$(lsb_release --id --short | tr 'A-Z' 'a-z')/apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb
sudo apt install -y -V ./apache-arrow-apt-source-latest-$(lsb_release --codename --short).deb

sudo apt update
# Are the glib deps necessary?
sudo apt install -y -V \
  libarrow-dev libarrow-glib-dev \
  libparquet-dev libparquet-glib-dev \
  libarrow-dataset-dev libarrow-dataset-glib-dev
```

Then in R

```{R}
Sys.setenv("NOT_CRAN" = TRUE)
install.packages("arrow")

# This is the only was I got it to detect the parquet C++ binaries...
# Confirm by spotting the build flag "-DARROW_R_WITH_PARQUET"
arrow::install_arrow()
```

