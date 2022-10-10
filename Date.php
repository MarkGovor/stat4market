<?php

class Date
{
    static function repeatDaysBetweenDates(string $day, string $startDate, string $endDate): int
    {
        try {
            $start = new DateTime($startDate);
            $end = new DateTime($endDate);
        } catch (Exception $e) {
            print_r('error');
            die;
        }

        $count = 0;

        $period = new DatePeriod($start, DateInterval::createFromDateString('1 day'), $end);

        foreach ($period as $date) {

            if($date->format('l') == $day) {
                $count++;
            }
        }

        return $count;
    }
}

$count = Date::repeatDaysBetweenDates('Tuesday', '01.09.2022', '11.10.2022');
print_r($count);