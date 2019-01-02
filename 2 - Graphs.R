library(ggplot2)

#Attendees over time
aggregate_dates <- event_registration_data %>% group_by(order.date) %>% summarise(total_attendees = length(order.date))
#if we want to know tech
#aggregate_dates <- event_registration_data %>% group_by(order.date, tech) %>% summarise(total_attendees = length(order.date))
#or
#aggregate_dates <- event_registration_data %>% group_by(order.date) %>% summarise(total_attendees = length(order.date), total_tech_attendees = sum(tech))

attendee_plot <- ggplot(aggregate_dates, aes(x=order.date, y = total_attendees)) + geom_line() + xlab('Date') + ylab('New Attendees')

#Challenge! Add similar analysis based on final attendee status
filter(event_registration_data, attendee.status == 'Checked In') #returns a data frame

aggregate_attendee_status <- filter(event_registration_data, attendee.status == 'Checked In') %>% group_by(order.date) %>% summarise(attendee.status = length(order.date))
attendee_status_plot <- ggplot(aggregate_attendee_status, aes(x=order.date, y = attendee.status)) + geom_line() + xlab('Date') + ylab('Attendee Status')


#Breakdown by Discipline
disc_breakdown <- ggplot(event_registration_data, aes(x = discipline)) + geom_bar(aes(fill = discipline)) + theme(legend.position="none") + xlab('Discipline') + ylab("Number of Registrants")
event_attendee_data <- event_registration_data %>% filter(attendee.status=='Checked In')
event_attendee_data <- ggplot(event_attendee_data, aes(x = discipline)) + geom_bar(aes(fill = discipline)) + theme(legend.position="none") + xlab('Discipline') + ylab("Number of Attendees")

#Challenge! Make a breakdown by year
year_breakdown <- ggplot(event_registration_data, aes(x = year)) + geom_bar(aes(fill = year)) + theme(legend.position="none") + xlab('Year') + ylab("Number of Registrants")

