library(ggplot2)
library(sitools)

mac2name = function(data) {
	data$mac = as.character(data$mac)
	data$mac[data$mac == '01:00:5e:7f:ff:fa'] = 'Multicast'
	data$mac[data$mac == '00:17:88:29:55:4d'] = 'Hue Bridge'
	data$mac[data$mac == '88:4a:ea:dd:b4:7c'] = 'Neato Robot Vac'
	data$mac[data$mac == '48:74:6e:6a:fb:47'] = 'iPhone 5s'
	data$mac[data$mac == 'd0:03:4b:50:75:44'] = 'Apple TV'
	data$mac[data$mac == '78:4F:43:6E:F4:b1'] = 'MacBook Pro'
	data$mac[data$mac == '44:65:0d:b4:b2:f5'] = 'Amazon Echo'
	data$mac[data$mac == 'f8:f0:05:f7:70:21'] = 'WINC-70-21'
	data$mac[data$mac == '78:4f:43:6e:f4:b1'] = 'James\' iPad'# (1)'
	data$mac[data$mac == '18:65:90:43:0c:58'] = 'James\' iPad'# (2)'
	data$mac[data$mac == 'b0:70:2d:e4:1e:82'] = 'James\' iPad'# (3)'
	data$mac[data$mac == '88:30:8a:77:5f:cc'] = 'James\' iPad'# (4)'
	data$mac[data$mac == '78:7e:61:90:e4:c0'] = 'James\' iPad'# (5)'
	data$mac[data$mac == '70:ee:50:12:84:aa'] = 'James\' iPad'# (6)'
	data$mac[data$mac == '84:89:ad:3e:33:66'] = 'James\' iPad'# (7)'
	data$mac[data$mac == '6c:19:c0:81:a9:cb'] = 'James\' iPad'# (8)'
	data$mac[data$mac == 'f0:9f:c2:30:7f:59'] = 'Ubiquiti Access Point'
	data$mac[data$mac == 'ff:ff:ff:ff:ff:ff'] = 'Broadcast'
	data$mac[data$mac == '3c:46:d8:bc:9b:f4'] = 'TP Link MR6400'
	data$mac[data$mac == '08:02:8e:97:da:3d'] = 'DLink Switch'
	data$mac[data$mac == '50:c7:bf:0b:0a:71'] = '2x TP Link HS110'# (1)'
	data$mac[data$mac == '50:c7:bf:0b:08:2e'] = '2x TP Link HS110'# (2)'
	data$mac[data$mac == 'd0:52:a8:45:41:f6'] = 'SmartThings Hub'
	data$mac[data$mac == 'f0:fe:6b:28:ca:e2'] = 'Foobot'
	data = data[data$mac != 'TP Link MR6400',]
	return(data)
}

data = mac2name(read.csv('mac-service-bytes.csv'))
data$service = as.character(data$service)
data$service[data$service == '-'] = 'other'
ggplot(data, aes(mac)) +
	labs(x = "Originating Device", y = "Transmitted (bytes)") +
	geom_bar(aes(weight = bytes, fill = service), las = 2) +
	#geom_bar(aes(reorder(mac, -bytes), bytes, fill = service), las = 2, stat='identity') +
	scale_y_continuous(labels=f2si) +
	theme_bw(base_size=14) +
	#scale_fill_brewer(palette = 'Set2') +
	theme(
		#panel.grid.major = element_line(colour = "white"),
		#panel.grid.minor = element_line(colour = "white"),
		axis.text = element_text(size = 16),
		axis.text.x = element_text(angle=90,hjust=1,vjust=0.5),
		#axis.title = element_text(size = 20, face="bold")
		axis.title = element_text(size = 18),
		legend.text=element_text(size=14)
	)
ggsave('mac-service-bytes.pdf')

data = mac2name(read.csv('mac-protocol-bytes.csv'))
ggplot(data, aes(mac)) +
	labs(x = "Originating Device", y = "Transmitted (bytes)") +
	geom_bar(aes(weight = bytes, fill = protocol), las = 2) +
	scale_y_continuous(labels=f2si) +
	theme_bw(base_size=14) +
	#scale_fill_brewer(palette = 'Set2') +
	theme(
		#panel.grid.major = element_line(colour = "white"),
		#panel.grid.minor = element_line(colour = "white"),
		axis.text = element_text(size = 16),
		axis.text.x = element_text(angle=90,hjust=1,vjust=0.5),
		#axis.title = element_text(size = 20, face="bold")
		axis.title = element_text(size = 18),
		legend.text=element_text(size=14)
	)
ggsave('mac-protocol-bytes.pdf')

#data = mac2name(read.csv('mac-service-bytes-resp.csv'))
#ggplot(data, aes(mac)) +
#	labs(x = "Responding Device", y = "Transmitted (bytes)") +
#	geom_bar(aes(weight = bytes, fill = service), las = 2) +
#	scale_y_continuous(labels=f2si) +
#	theme_bw(base_size=14) +
#	theme(
#		#panel.grid.major = element_line(colour = "white"),
#		#panel.grid.minor = element_line(colour = "white"),
#		axis.text = element_text(size = 16),
#		axis.text.x = element_text(angle=90,hjust=1,vjust=0.5),
#		#axis.title = element_text(size = 20, face="bold")
#	)
#ggsave('mac-service-bytes-resp.pdf')

data0 = mac2name(read.csv('orig-resp-bytes-extern.csv'))
data0$type = rep('external', nrow(data0))
data1 = mac2name(read.csv('orig-resp-bytes-intern.csv'))
data1$type = rep('internal', nrow(data1))
data = rbind(data0, data1)
ggplot(data, aes(mac)) +
	labs(x = "Device", y = "Traffic (bytes)") +
	geom_bar(aes(weight = bytes, fill = type), las = 2) +
	scale_y_continuous(labels=f2si) +
	theme_bw(base_size=14) +
	#scale_fill_brewer(palette = 'Set2') +
	theme(
		#panel.grid.major = element_line(colour = "white"),
		#panel.grid.minor = element_line(colour = "white"),
		axis.text = element_text(size = 16),
		axis.text.x = element_text(angle=90,hjust=1,vjust=0.5),
		#axis.title = element_text(size = 20, face="bold")
		axis.title = element_text(size = 18),
		legend.text=element_text(size=14)
	)
ggsave('mac-type-bytes.pdf')
