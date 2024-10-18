import datetime
import csv

# Set start and end date
start_date = datetime.datetime(2022, 5, 2, 0, 0)
end_date = datetime.datetime(2023, 12, 31, 23, 0)

# Create a list of datetime every hour between start and end date
date_list = []
delta = datetime.timedelta(hours=1)
while start_date <= end_date:
    date_list.append(start_date)
    start_date += delta

# Write datetime list to CSV file
with open('DateTimeHourly.csv', mode='w', newline='') as file:
    writer = csv.writer(file)
    writer.writerow(['dateTime'])
    for date in date_list:
        writer.writerow([date.strftime('%d/%m/%Y %H:%M:%S')])