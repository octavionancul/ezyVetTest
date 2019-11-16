<?php

// ('server','user','password','database')
$mysqli = new mysqli('localhost', 'root', '', 'ezyvet_octavionancul');

//file to load
$fileName = 'contact_list .csv';

if ($mysqli->connect_error) {
    die('Connect Error (' . $mysqli->connect_errno . ') '
            . $mysqli->connect_error);
}
//drop temporary table if exists
$query = <<<EOF
    drop table IF EXISTS tmp_contact_list;
EOF;

$mysqli->query($query);

//create temporary table to load csv file
$query = <<<EOF
    CREATE TABLE tmp_contact_list (
    business VARCHAR(64), 
    title VARCHAR(64), 
    first_name VARCHAR(64), 
    last_name VARCHAR(64), 
    date_of_birth VARCHAR(64), 
    address_line_1 VARCHAR(100), 
    address_line_2 VARCHAR(100), 
    suburb VARCHAR(64),
    city VARCHAR(64),
    post_code VARCHAR(16), 
    home_number VARCHAR(64), 
    fax_number VARCHAR(64), 
    work_number VARCHAR(64),
    mobile_number VARCHAR(64),
    other_number VARCHAR(64), 
    notes VARCHAR(255)
    )
     ;
EOF;

$mysqli->query($query);

//Loading csv data into temporary table
$query = <<<EOF
    LOAD DATA LOCAL INFILE '$fileName'
     INTO TABLE tmp_contact_list
     FIELDS TERMINATED BY ',' 
     LINES TERMINATED BY '\n'
     IGNORE 1 ROWS
    (
        business, 
        title, 
        first_name, 
        last_name, 
        date_of_birth, 
        address_line_1, 
        address_line_2, 
        suburb,
        city,
        post_code, 
        home_number, 
        fax_number, 
        work_number,
        mobile_number,
        other_number, 
        notes
    )
EOF;

$mysqli->query($query);

//truncate tables
$query = "truncate table contact;";
$mysqli->query($query);

$query = "truncate table address;";
$mysqli->query($query);

$query = "truncate table phone;";
$mysqli->query($query);

$result = $mysqli->query( "
select 
    case when replace(trim(CONCAT(UCASE(LEFT(title, 1)), LCASE(SUBSTRING(title, 2)))),'.','') <> '' 
    then replace(trim(CONCAT(UCASE(LEFT(title, 1)), LCASE(SUBSTRING(title, 2)))),'.','')  else 'Mr' end title,
    CONCAT(UCASE(LEFT(substring_index(trim(first_name),' ',1) , 1)),LCASE(SUBSTRING(substring_index(trim(first_name),' ',1) , 2))) as first_name ,
    case when locate(' ',trim(first_name) ) > 0 then CONCAT(UCASE(LEFT( substring_index(first_name,' ',-1), 1)), LCASE(SUBSTRING( substring_index(first_name,' ',-1), 2)))  else CONCAT(UCASE(LEFT(last_name, 1)), LCASE(SUBSTRING(last_name, 2))) end last_name ,
    case when trim(business)<>'' and ( upper(substring_index(trim(business), ' ',1))= binary substring_index(trim(business), ' ',1) or locate('.',substring_index(trim(business), ' ',1))>1 ) then concat(upper(substring_index(trim(business), ' ',1)),SUBSTRING(trim(business), locate(' ',trim(business))) ) else trim(business) end company_name,
    case when length(SUBSTRING_INDEX(replace(date_of_birth,'-','/'), '/', -1))=2 
    then str_to_date(concat(substring(replace(date_of_birth,'-','/'),1 , length(replace(date_of_birth,'-','/'))-2),'19',SUBSTRING_INDEX(replace(date_of_birth,'-','/'), '/', -1)),'%m/%d/%Y')
    when length(SUBSTRING_INDEX(replace(date_of_birth,'-','/'), '/', -1))=4 
    then str_to_date(replace(date_of_birth,'-','/'),'%m/%d/%Y') else '1900-01-01' end date_of_birth,
    notes,
    address_line_1 as street1,
    address_line_2 as street2,
    suburb,
    city,
    post_code,
    case when LENGTH(TRIM(home_number))>0 AND LEFT(TRIM(home_number),2)<>'64' and LEFT(TRIM(replace(replace(home_number,')',''),'(','')),2)<>'09' then  CONCAT('09',home_number) else TRIM(replace(replace(home_number,')',''),'(','')) end home_number,
    case when LENGTH(TRIM(work_number))>0 AND LEFT(TRIM(work_number),2)<>'64' and LEFT(TRIM(replace(replace(work_number,')',''),'(','')),2)<>'09' then  CONCAT('09',work_number) else TRIM(replace(replace(work_number,')',''),'(','')) end work_number,
    case when LEFT(TRIM(mobile_number),2)<>'64' and LENGTH(TRIM(mobile_number))>0 then concat('64',trim(mobile_number)) else trim(mobile_number) end mobile_number,
    other_number 
from 
    ezyvet_octavionancul.tmp_contact_list;
");
//echo "Processing ".$mysqli->affected_rows." records";

while ($row =  mysqli_fetch_assoc($result))
{    
    //insert contacts
    $query = "insert into contact ( title, first_name, last_name, company_name, date_of_birth, notes) 
    values 
    ('".$mysqli->real_escape_string($row['title'])."',
    '".$mysqli->real_escape_string($row['first_name'])."',
    '".$mysqli->real_escape_string($row['last_name'])."',
    '".$mysqli->real_escape_string($row['company_name'])."',
    '".$mysqli->real_escape_string($row['date_of_birth'])."',
    '".$mysqli->real_escape_string($row['notes'])."')";
   
    $mysqli->query($query);
    
    //get contact_id
    $contact_id= $mysqli->insert_id;

    //insert address
    $query = "insert into address ( contact_id, street1 , street2, suburb, city, post_code) 
    values 
    ('".$contact_id."',
    '".$mysqli->real_escape_string($row['street1'])."',
    '".$mysqli->real_escape_string($row['street2'])."',
    '".$mysqli->real_escape_string($row['suburb'])."',
    '".$mysqli->real_escape_string($row['city'])."',
    '".$mysqli->real_escape_string($row['post_code'])."')";

    $mysqli->query($query);

    //insert phones by type
    $array = array(
        'phones' => array(
            array( 'type' => 'Home', 'number' => $row['home_number']),
            array( 'type' => 'Work',  'number' => $row['work_number']),
            array( 'type' => 'Mobile', 'number' => $row['mobile_number']),
            array( 'type' => 'Other',  'number' => $row['other_number'])
        ));
    
    foreach($array['phones'] as $phone){
        
        if ($phone['number'] <> ''){
        
            $query = "insert into phone ( contact_id, name , content, type) 
            values 
            ('".$contact_id."',
            '',
            '".$mysqli->real_escape_string($phone['number'])."',
            '".$mysqli->real_escape_string($phone['type'])."' )";
        
            $mysqli->query($query);
        }
    }   
}



//drop temporary table if exists
$query = <<<EOF
    drop table IF EXISTS tmp_contact_list;
EOF;

$mysqli->query($query);

/*
    SELECT * 
    FROM 
        contact as c 
    left join 
        address as a 
    on 
        c.id = a.contact_id
    left join 
        phone as p 
    on 
        c.id = p.contact_id;
*/

$mysqli->close();

//echo "Process completed";
?>