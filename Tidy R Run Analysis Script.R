X_test <- read.table("X_test.txt", header=FALSE, fill=TRUE)
y_test <- read.table("y_test.txt", header=FALSE)
subject_test <- read.table("subject_test.txt", header=FALSE)
subject_train <- read.table("subject_train.txt", header=FALSE)
X_train <- read.table("X_train.txt", header=FALSE, fill=TRUE)
y_train <- read.table("y_train.txt", header=FALSE)
features <- read.table("features.txt", header=FALSE, stringsAsFactors=FALSE)

activity <- read.table("activity_labels.txt", header=FALSE, stringsAsFactors=FALSE)

X_bind <- rbind(X_test, X_train)
y_bind <- rbind(y_test, y_train)
subject_bind <- rbind(subject_test, subject_train)

avector <- as.vector(features[ , 2])  

avector2 <- make.names(avector, unique = TRUE)

colnames(X_bind) <- avector2  

selectVector <- grep("mean|std", names(X_bind), ignore.case=FALSE)

X_bind1 <- X_bind[ , selectVector]

selectVectorF <- !grepl("meanFreq", names(X_bind1), ignore.case=FALSE)

table(selectVectorF)

X_bind2 <- X_bind1[ , selectVectorF]

pre_tidy1 <- cbind(y_bind, X_bind2)

pre_tidy2 <- cbind(subject_bind, pre_tidy1)

merged_Data = merge(pre_tidy2, activity, by.x=2, by.y=1, all=TRUE)

pre_tidy3 <- merged_Data[ , c(2, 69, 3:68)]

colnames(pre_tidy3)[1] <- "subject.id"
colnames(pre_tidy3)[2] <- "activity.label"

colnames(pre_tidy3) <- tolower(names(pre_tidy3))

freq <- sub("^f+", "freq.", names(pre_tidy3))
time <- sub("^t+", "time.", freq)
body <- sub("body+", "body.", time)
body2 <- sub("body.body+", "body.", body)
gravity <- sub("gravity+", "gravity.", body2)
jerk <- sub("jerk+", ".jerk", gravity)
mag <- sub("mag+", ".mag", jerk)
periods <- sub("\\.\\.", "", mag)
colnames(pre_tidy3) <- periods

tidy1 <- pre_tidy3

install.packages("dplyr")
library(dplyr)

tidy1 <- tbl_df(tidy1)

tidy2 <- group_by(tidy1, subject.id, activity.label) %>% summarise_each(funs(mean), "time.body.acc.mean.x" : "freq.body.gyro.jerk.mag.std")

write.table(tidy2, file="tidy2RM.txt", row.names=FALSE, col.names=TRUE, sep=" ", quote=FALSE)
tidy_data <- read.table("tidy2RM.txt", header = TRUE)
View(tidy_data)