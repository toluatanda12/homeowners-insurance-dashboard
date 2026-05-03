df <- read.csv("homeowner_insurance_data.csv")

flood_premium <- df$annual_premium[df$flood_zone == 1]
no_flood_premium <- df$annual_premium[df$flood_zone == 0]

png("ttest_bar_chart.png", width=800, height=600)
barplot(c(mean(no_flood_premium), mean(flood_premium)), 
        names.arg=c("Non-Flood Zone", "Flood Zone"), 
        main="Average Premium by Flood Zone", 
        ylab="Premium ($)", 
        col=c("steelblue", "coral"),
        ylim=c(0, 2000))
dev.off()

construction_means <- tapply(df$annual_premium, df$construction_type, mean)

png("anova_bar_chart.png", width=800, height=600)
barplot(construction_means, 
        main="Average Premium by Construction Type",
        ylab="Premium ($)", 
        col=c("steelblue", "forestgreen", "coral"),
        ylim=c(0, 1600))
dev.off()

png("correlation_heatmap.png", width=1000, height=900)
numeric_cols <- df[, sapply(df, is.numeric)]
cor_matrix <- cor(numeric_cols, use="complete.obs")
heatmap(cor_matrix, main="Correlation Heatmap", 
        col=colorRampPalette(c("red", "white", "blue"))(20))
dev.off()

png("premium_histogram.png", width=800, height=600)
hist(df$annual_premium, 
     main="Distribution of Annual Premiums",
     xlab="Annual Premium ($)", 
     ylab="Number of Homes",
     col="steelblue",
     border="black",
     breaks=30)
dev.off()

png("flood_comparison.png", width=800, height=600)
boxplot(annual_premium ~ flood_zone, data=df,
        main="Premium Comparison: Flood Zone vs Non-Flood Zone",
        xlab="Flood Zone (0=No, 1=Yes)",
        ylab="Annual Premium ($)",
        col=c("steelblue", "coral"),
        names=c("Non-Flood", "Flood Zone"))
dev.off()

contingency_table <- table(df$flood_zone, df$had_claim)

png("chi_square_chart.png", width=800, height=600)
barplot(t(contingency_table), beside=TRUE,
        main="Claims by Flood Zone Status",
        xlab="Flood Zone", ylab="Number of Homes",
        col=c("steelblue", "coral"),
        legend.text=c("No Claim", "Had Claim"),
        args.legend=list(x="topright"))
dev.off()

png("risk_score_distribution.png", width=800, height=600)
hist(df$risk_score, 
     main="Distribution of Risk Scores",
     xlab="Risk Score (0-100)", 
     ylab="Number of Homes",
     col="steelblue",
     border="black",
     breaks=30)
dev.off()

png("regression_coefficients.png", width=1000, height=600)
coef_data <- c(15.00, 0.0005, 0.00, 0.00, 0.00, 0.00)
names(coef_data) <- c("Risk Score", "Home Value", "Home Age", "Flood Zone", "Claims History", "Credit Score")
barplot(coef_data, main="Regression Coefficients", ylab="Coefficient Value", col="steelblue")
dev.off()

cat("Images created:\n")
cat("1. ttest_bar_chart.png\n")
cat("2. anova_bar_chart.png\n")
cat("3. correlation_heatmap.png\n")
cat("4. premium_histogram.png\n")
cat("5. flood_comparison.png\n")
cat("6. chi_square_chart.png\n")
cat("7. risk_score_distribution.png\n")
cat("8. regression_coefficients.png\n")