D_origin <-0.217

p_ks <- ggplot(data = dks,aes(x =D))+
  geom_histogram(aes(y=after_stat(density)),alpha=.2, color ="black", fill = "white",size = 0.3,bins = 15) +
  geom_density(aes(y=after_stat(density)),size = 1.5)+
  geom_vline(xintercept = D_origin, linetype = "dashed", color = "#e06666",size = 1.5)+
  annotate("text", x = D_origin, y = 5, label = "Origin", size = 4)+
  theme_bw(base_size = 12) + 
  labs(
    title = "Distribution of statistic D in K-S test",
    x = "maximum difference",
    y = "density of statistic"
  )+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(
    axis.title = element_text (size =15),
    axis.text = element_text(size = 10))
print(p_ks)