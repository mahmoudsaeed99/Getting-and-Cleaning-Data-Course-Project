
library(dplyr)

activities <- read.table("activity_labels.txt" , col.names = c("code" , "activity"))
features <- read.table("features.txt" , col.names = c("n" , "functions"))
subject_test <- read.table("subject_test.txt" , col.names = c("subject"))
x_test <- read.table("X_test.txt" ,col.names = features$functions)
y_test <- read.table("Y_test.txt" ,col.names = c("code"))
x_trian <- read.table("X_train.txt" ,col.names = features$functions)
y_train <- read.table("y_train.txt" ,col.names = c("code"))
subject_trian <- read.table("subject_train.txt" , col.names = c("subject"))

merge_x <- rbind(x_test , x_trian)
merge_y <- rbind(y_test , y_train)
merge_subject <- rbind(subject_test , subject_trian)

merge_data <- cbind(merge_subject , merge_x , merge_y)
## get all subject , code and also contain 'mean' and 'std'
tidyData <- merge_data %>% select(subject , code , contains("mean") , contains("std"))

tidyData$code <- activities[tidyData$code , 2]

names(tidyData)[2] = "activity"
names(tidyData) <- gsub("Acc","Accelerometer" , names(tidyData))
names(tidyData) <- gsub("^t","Time" , names(tidyData))
names(tidyData) <- gsub("^f","Frequency" , names(tidyData))
names(tidyData) <- gsub("Gyro","Gyroscope" , names(tidyData))
names(tidyData) <- gsub("BodyBody","Body" , names(tidyData))
names(tidyData) <- gsub("-mean()","Mean" , names(tidyData))
names(tidyData) <- gsub("-std()","STD" , names(tidyData)) 
names(tidyData) <- gsub("-freq()","Frequency" , names(tidyData)) 
names(tidyData) <- gsub("Mag","Magnitude" , names(tidyData))
names(tidyData) <- gsub("gravity","gravity" , names(tidyData))
names(tidyData) <- gsub("angle","Angle" , names(tidyData))
names(tidyData) <- gsub("tBody","TimeBody" , names(tidyData))




newDataSet <- tidyData %>%
              group_by(subject , activity)%>%
              summarise_all(funs(mean))


write.table(newDataSet,"newData.txt",row.names = F)















