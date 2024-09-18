# A script to parse and make some plots of example SARS-CoV

# Kim Medina
# ctmedina2@dons.usfca.edu
# Sept. 16, 2024

# load packages
library(ggplot2)
library(dplyr)

# load in SNP data
snp_data <- read.csv("data/sample_snp_data.csv")

# use dplyr to subset out just the first sample from the data
sample_SRR12433063 <- snp_data %>%
  filter(sample == "SRR12433063")

# use group_by and summarize to calculate mean of the qual column
# but grouped by sample
snp_data %>%
  group_by(sample) %>%
  summarise(mean_quality = mean(qual),
            sd_quality = sd(qual))

# use group_by and summarize to get a count of the number high quality
# SNPs in each of the sample
snp_data %>%
  filter(qual > 175) %>%
  group_by(sample) %>%
  tally()

# use select to pull out only a few columns of interest
snp_data %>%
  select(sample, pos, ref, alt)

# introducing ggplot (gg = grammar of graphics)
ggplot(data = iris,
       aes(x = Sepal.Length,
           y = Sepal.Width,
           color = Species,
           size = Petal.Length)) +
  geom_point() +
  geom_smooth(method = "lm") +
  # line below changes to colorblind friendly when ran
  # scale_color_viridis_d() +
  labs(title = "Flower measurements of iris spp.",
       x = "Sepal Length",
       y = "Sepal Width")


# put together dplyr and ggplot to visualize
# the quality score of a SNP call by position in the genome
# colored by sample, but only for SNPs with quality > 150
snp_data %>%
  filter(qual > 20) %>%
  # if you wanna filter further, use lines below
  # filter(pos > 8000) %>%
  # filter(pos < 20000) %>%
  ggplot(aes(x = pos,
             y = qual,
             color = sample)) +
  geom_point(size = 3) +
  labs(x = " Position in Genome",
       y = "SNP Quality Score",
       title = "SNP quality by sample")

