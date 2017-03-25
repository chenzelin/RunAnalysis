library(tidyr)
library(dplyr)

# Read data from txt files
train.set <- read.table("./UCI HAR Dataset/train/X_train.txt")
train.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt")
train.labels <- read.table("./UCI HAR Dataset/train/y_train.txt")

test.set <- read.table("./UCI HAR Dataset/test/X_test.txt")
test.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt")
test.labels <- read.table("./UCI HAR Dataset/test/y_test.txt")

features <- read.table("./UCI HAR Dataset/features.txt")
activity.labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Merge the training and test set, applying the feature name
dataset <- rbind(train.set, test.set)
colnames(dataset) <- features[, 2]

# Merge the training and test labels, replace numbers with activity names
label <- rbind(train.labels, test.labels)
label <- merge(label, activity.labels, by=1)[,2]

# Merge the training and test subjects
subject <- rbind(train.subject, test.subject)
colnames(subject) <- "subject"

# Merge all the data
data <- cbind(subject, label, dataset)

# Extract the mean and std to create a new dataset
newset <- data[,c(1, 2, grep("-mean|-std", colnames(data)))]

# Create a tidy set with the means grouped by activity/subject
tidydata <- newset %>%
gather(activity, value, -(subject:label)) %>%
group_by(subject, label, activity) %>%
summarize(mean = mean(value)) %>%
spread(activity, mean)

# Save the result
write.table(tidydata, file="./UCI HAR Dataset/tidy_data.txt")
