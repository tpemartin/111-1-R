data9hw1 <- read.csv("/Users/liurenhao/Documents/GitHub/111-1-econDV/111-1-econDV/week9/econDV2作業1/工作表 2-表格 1.csv")
# https://web02.mof.gov.tw/njswww/WebMain.aspx?sys=100&funid=defjsptgl

tidyr::pivot_longer(
  data = data9hw1,
  cols = 2:20, 
  names_to = "Product",values_to = "Export"
) |> mutate(year=as.numeric(year)
)  |> mutate(Export=as.numeric(Export))-> data9hw1_2


plot$ggplot <- ggplot(data = data9hw1_2 )
plot$geoms <- list(geom_tile(aes(x=year,y=Product,fill=Export),colour="gray"))
plot$themes <- list(theme(
  axis.ticks.y=element_blank()),scale_x_continuous(expand=c(0,0)),xlab(NULL),ylab(NULL))
plot$scale <- list(
  scale_fill_gradient2(
    limit=c(0,1),
    low = "white",
    high="#f00000"
  ),
  scale_y_discrete(limits=c("X19.其他","X18.光學及精密儀器.鐘錶.樂器","X17.運輸工具","X16.機械及電機設備",
                            "X15.基本金屬及其製品","X14.珠寶及貴金屬製品","X13.非金屬礦物製品","X12.鞋.帽及其他飾品","X11.紡織品",
                            "X10.紙漿.紙及其製品.印刷品","X9.木及木製品","X8.毛皮及其製品","X7.塑膠.橡膠及其製品","X6.化學品",
                            "X5.礦產品","X4.調製食品.飲料及菸酒","X3.動植物油脂","X2.植物產品","X1.活動物.動物產品")))
plot$explain = list(
  labs(
    title="台灣出口中國產品",
    subtitle="歷年比重變化",
    caption="資料來源：中華民國財政部"
  ),xlab(NULL)
)


plot$ggplot+plot$geoms+plot$themes+plot$scale+plot$explain ->g1
g1+annotate("rect", 
            xmin = 2000.5, xmax = 2021.5, 
            ymin = 18.5, ymax = 17.5,
            alpha = .00001,colour = "pink")
ggdash()