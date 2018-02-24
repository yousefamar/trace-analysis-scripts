library(ggplot2)
library(sitools)

data = read.csv('net-io-service.csv')
data$timestamp = as.POSIXct(data$timestamp, origin="1970-01-01", tz="GMT")

ggplot(data, aes(timestamp, io, colour=service)) +
	labs(x = "Time", y = "Traffic (bytes)") +
	geom_line() +
	#scale_x_date(format = "%b-%Y")
	theme_bw() +
	#scale_fill_brewer(palette = 'Set2') +
	scale_y_continuous(labels=f2si) +
	theme(
		#panel.grid.major = element_line(colour = "white"),
		#panel.grid.minor = element_line(colour = "white"),
		#axis.text = element_text(size = 18),
		axis.text.x = element_text(angle=90,hjust=1,vjust=0.5),
		#axis.title = element_text(size = 20, face="bold")
	)
ggsave('net-io-service.pdf', width=10, height=5)
