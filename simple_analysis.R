cat("========================================\n")
cat("INSURANCE DATA ANALYSIS\n")
cat("========================================\n\n")

df <- read.csv("homeowner_insurance_data.csv")
cat("Loaded", nrow(df), "records\n\n")

cat("Basic Statistics:\n")
cat("Average Home Value: $", format(round(mean(df$home_value), 0), big.mark=","), "\n")
cat("Average Risk Score:", round(mean(df$risk_score), 1), "\n")
cat("Average Premium: $", format(round(mean(df$annual_premium), 0), big.mark=","), "\n")
cat("Claim Rate:", round(mean(df$had_claim) * 100, 1), "%\n")
cat("Flood Zone Homes:", sum(df$flood_zone), "(", round(mean(df$flood_zone)*100, 1), "%)\n\n")

flood_avg <- mean(df$annual_premium[df$flood_zone == 1])
no_flood_avg <- mean(df$annual_premium[df$flood_zone == 0])
cat("Premium Comparison:\n")
cat("  Flood zone homes: $", format(round(flood_avg, 0), big.mark=","), "\n")
cat("  Non-flood homes: $", format(round(no_flood_avg, 0), big.mark=","), "\n")
cat("  Difference: $", format(round(flood_avg - no_flood_avg, 0), big.mark=","), "\n")
cat("  Percentage increase:", round((flood_avg - no_flood_avg)/no_flood_avg * 100, 1), "%\n\n")

cat("Risk Score Distribution:\n")
risk_breaks <- c(0, 30, 50, 70, 100)
risk_labels <- c("Low (0-30)", "Medium (31-50)", "High (51-70)", "Very High (71-100)")
df$risk_category <- cut(df$risk_score, breaks=risk_breaks, labels=risk_labels, include.lowest=TRUE)
risk_table <- table(df$risk_category)
for(i in 1:length(risk_table)) {
  cat("  ", names(risk_table)[i], ":", risk_table[i], "homes (", round(risk_table[i]/nrow(df)*100, 1), "%)\n")
}

png("premium_histogram.png", width=800, height=600)
hist(df$annual_premium, 
     main="Distribution of Annual Insurance Premiums",
     xlab="Annual Premium ($)", 
     ylab="Number of Homes",
     col="steelblue",
     border="black",
     breaks=30)
dev.off()
cat("\nSaved: premium_histogram.png\n")

png("flood_comparison.png", width=800, height=600)
boxplot(annual_premium ~ flood_zone, data=df,
        main="Premium Comparison: Flood Zone vs Non-Flood Zone",
        xlab="Flood Zone (0=No, 1=Yes)",
        ylab="Annual Premium ($)",
        col=c("lightblue", "lightcoral"),
        names=c("Non-Flood", "Flood Zone"))
dev.off()
cat("Saved: flood_comparison.png\n")

summary_data <- data.frame(
  Metric = c("Total Homes", "Average Home Value", "Average Risk Score", 
             "Average Premium", "Claim Rate", "Flood Zone %",
             "Flood Zone Premium", "Non-Flood Premium", "Premium Difference"),
  Value = c(
    nrow(df),
    round(mean(df$home_value), 0),
    round(mean(df$risk_score), 1),
    round(mean(df$annual_premium), 0),
    paste0(round(mean(df$had_claim) * 100, 1), "%"),
    paste0(round(mean(df$flood_zone) * 100, 1), "%"),
    round(flood_avg, 0),
    round(no_flood_avg, 0),
    round(flood_avg - no_flood_avg, 0)
  )
)

write.csv(summary_data, "analysis_results.csv", row.names=FALSE)
cat("Saved: analysis_results.csv\n\n")

cat("========================================\n")
cat("ANALYSIS COMPLETE\n")
cat("========================================\n")