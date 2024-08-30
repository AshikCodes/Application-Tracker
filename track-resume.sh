#!/bin/bash


echo -e "\033[1;35mResume Tracking Automation\033[0m"



BLUE="\033[1;34m"
GREEN="\033[1;32m"
ORANGE="\033[38;5;208m"
RESET="\033[0m"



fortune | cowsay 

current_datetime=$(date +"%Y-%m-%d %H:%M:%S")

current_month=$(date +"%Y-%m-01 %H:%M:%S")

current_day=$(date +"%Y-%m-%d 00:30:00")

start_date="2024-05-29 14:00:00"

cd /Users/ashikreji/Downloads/ 

echo "------------------------------------------------------------------------------"
echo -e "\033[1;32mResume Summary\033[0m"
echo "------------------------------------------------------------------------------"

total_resumes_sent=$(find . \( -name "*Resume.pdf*" -o -name "*Resume (1).pdf*" -o -name "*Resume (2).pdf*"  -o -name "*Resume (3).pdf*" \) -newermt "$start_date" | wc -l)

printf "\033[1;32m%-40s : %.3f\033[0m\n" "Total Resumes Sent" "$total_resumes_sent"


resumes_sent_this_month=$(find . \( -name "*Resume.pdf*" -o -name "*Resume (1).pdf*" -o -name "*Resume (2).pdf*"  -o -name "*Resume (3).pdf*" \) -newermt "$current_month" ! -newermt "$current_datetime" | wc -l)

printf "\033[1;32m%-40s : %.3f\033[0m\n" "Resumes Sent This Month" "$resumes_sent_this_month"


resumes_sent_today=$(find . \( -name "*Resume.pdf*" -o -name "*Resume (1).pdf*" -o -name "*Resume (2).pdf*"  -o -name "*Resume (3).pdf*" \) -newermt "$current_day" ! -newermt "$current_datetime" | wc -l)

printf "\033[1;32m%-40s : %.3f\033[0m\n" "Resumes Sent Today" "$resumes_sent_today"




day_number=$(date +"%d")

daily_monthly_average=$(echo "scale=3; $resumes_sent_this_month / $day_number" | bc -l)

printf "\033[1;32m%-40s : %.3f\033[0m\n" "Average Resumes per Day (This Month)" "$daily_monthly_average"


start_date="2024-05-29"

current_date=$(date +%s)

start_date_seconds=$(date -j -f "%Y-%m-%d" "$start_date" +%s)

difference_seconds=$((current_date - start_date_seconds))

days_elapsed=$((difference_seconds / 86400))
daily_all_time_average=$(echo "scale=3; $total_resumes_sent / $days_elapsed" | bc -l)

printf "\033[1;32m%-40s : %.3f\033[0m\n" "Average Resumes per Day (All Time)" "$daily_all_time_average"



get_days_in_month() {
    local month=$1

    case $month in
        1|3|5|7|8|10|12) echo 31 ;;   
        4|6|9|11) echo 30 ;;          
        2) echo 28 ;;                
        *) echo "Invalid month" ;;
    esac
}

current_month2=$(date +"%m")
current_month2=${current_month2#0}
day_number=${day_number#0}
last_day_of_month=$(get_days_in_month $current_month2)
remaining_days=$((last_day_of_month - day_number))


goal_res_sent=625
pace=$(( (goal_res_sent - resumes_sent_this_month) / remaining_days ))
percent_increase_needed=$(echo "scale=3; (($pace - $daily_monthly_average) * 100) / $daily_monthly_average" | bc)

diagnosis="Still trying to figure out"


if (( $(echo "$percent_increase_needed > 1000.00" | bc -l) )); then
    diagnosis="You might need a miracle"
elif (( $(echo "$percent_increase_needed > 500.00" | bc -l) && $(echo "$percent_increase_needed <= 999.00" | bc -l) )); then
    diagnosis="Time to rethink your strategy"
elif (( $(echo "$percent_increase_needed > 200.00" | bc -l) && $(echo "$percent_increase_needed <= 499.00" | bc -l) )); then
    diagnosis="Get ready to hustle"
elif (( $(echo "$percent_increase_needed > 100.00" | bc -l) && $(echo "$percent_increase_needed <= 200.00" | bc -l) )); then
    diagnosis="Put on your game face"
elif (( $(echo "$percent_increase_needed > 0.00" | bc -l) && $(echo "$percent_increase_needed <= 99.00" | bc -l) )); then
    diagnosis="You’ve got this, no sweat"
elif (( $(echo "$percent_increase_needed >= -1.00" | bc -l) && $(echo "$percent_increase_needed <= -24.00" | bc -l) )); then
    diagnosis="Chill, you’re ahead"
else
    diagnosis="Still figuring it out, keep calm"
fi



echo "------------------------------------------------------------------------------"
echo -e "${ORANGE}Resume Tracking Goals${RESET}"
echo "------------------------------------------------------------------------------"

printf "${ORANGE}%-40s : %s${RESET}\n" "Target Resumes by End of Month" "625"

printf "${ORANGE}%-40s : %.3f resumes/day for "$remaining_days" days${RESET}\n" "Pace Needed to Meet Goal" "$pace"
printf "${ORANGE}%-40s : %.3f%%${RESET}\n" "Percentage Increase to Achieve Goal" "$percent_increase_needed"
printf "${ORANGE}%-40s : %s${RESET}\n" "Diagnosis" "$diagnosis"


echo "------------------------------------------------------------------------------"
echo -e "${BLUE}Application Results${RESET}"
echo "------------------------------------------------------------------------------"

printf "${BLUE}%-40s : %s${RESET}\n" "Interviews" "5"
printf "${BLUE}%-40s : %s${RESET}\n" "Pre-Screening" "1"
printf "${BLUE}%-40s : %s${RESET}\n" "OA's" "2"
