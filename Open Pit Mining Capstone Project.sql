use new_schema;

/*Top 10 Trucks which has transported maximum Payloads in tons*/

select `Primary Machine Name`, SUM(`Payload (kg)`)/1000 as `Total_Payload (t)` 
from movement_key_imp
group by `Primary Machine Name`
order by `Total_Payload (t)` desc
limit 10;

/*Top 10 Performing Trucks*/
select `Primary Machine Name`, ROUND(SUM(`Payload (kg)`)/SUM(`COMPLETEDCYCLEDURATION`),2) as `Load_per_sec (Kg)` 
from movement_key_imp
group by `Primary Machine Name`
order by `Load_per_sec (Kg)` desc;

select `Primary Machine Name`, `Source Location Name`, `Destination Location Name`, count(`Primary Machine Name`)
from movement_key_imp
group by `Primary Machine Name`, `Source Location Name`, `Destination Location Name`;

/*Production vs Plan*/
select ROUND(SUM(`Payload (kg)`)/1000,2) as Transported_Payload
from movement_key_imp;

select ROUND(SUM(`Payload (t)`),2) as Production_Payload
from cycle_key_imp
where `Cycle Type` != 'TruckCycle';

/*OEE Calculation View Tables */
create view cycle_OEE
as select `Primary Machine Name`, `Cycle Type`, `Primary Machine Category Name`, sum(`Available Time`) as Machine_AT, sum(`Down Time`) as Machine_DT, sum(`OPERATINGTIME (CAT)`) as Machine_OT, sum(`UNSCHEDULEDDOWNTIME`) as Machine_UT, (sum(`Available Time`)-sum(`Down Time`))*100/sum(`Available Time`) as Availability
from cycle_key_imp
group by `Primary Machine Name`
order by Availability;

create view delay_OEE
as select `Target Machine Name`, `Target Machine Class Category Name`, SUM(`Delay Finish - Start`) as Machine_SpeedLoss
from delay_key_imp
group by `Target Machine Name`
order by SUM(`Delay Finish - Start`);


/*creating view table for OEE calculations for all Machines*/

create view OEE
as with oee_table as ( 
select `Primary Machine Name`, `Cycle Type`, `Primary Machine Category Name`, `Machine_AT`, `Machine_DT`, `Machine_OT`, `Machine_UT`, `Availability`, `Machine_SpeedLoss`
from cycle_oee ce
left join delay_oee de
on ce.`Primary Machine Name` = de.`Target Machine Name`
) 

select *, (`Machine_OT`-`Machine_SpeedLoss`)*100/`Machine_OT` as Performance, (`Machine_OT`-`Machine_UT`)*100/(`Machine_OT`) as Quality
from oee_table;

/*Creating Stored Procedure for cycle table*/
DELIMITER $$
create procedure cycle_key (cycle_type varchar(50))
begin
select *
from cycle
where `Cycle Type` = cycle_type;
end $$
DELIMITER ;

/*Creating Stored Procedure for delay table*/
DELIMITER $$
create procedure delay_key (Machine_Class_Category_Name varchar(50))
begin
select `Description`, `Engine Stopped Flag`, `Field Notification Required Flag`, `Production Reporting Only Flag`, `Delay Class Name`, `Delay Class Category Name`, `Target Machine Name`, `Target Machine Class Name`, `Target Machine Class Description`, `Target Machine Class Category Name`, `Delay Finish - Start`
from delay
where `Target Machine Class Category Name` = Machine_Class_Category_Name;
end $$
DELIMITER ;

/*Creating Stored Procedure for OEE Calculations*/
DELIMITER $$
create procedure OEE_key (cycle_type varchar(50))
begin
select *
from oee
where `Cycle Type` = cycle_type;
end $$
DELIMITER ;

	
/*Creating Stored Procedure for movement table*/
DELIMITER $$
create procedure movement_key (Truck_Name varchar(10))
begin
select *
from movement
where `Primary Machine Name` = Truck_Name;
end $$
DELIMITER ;
