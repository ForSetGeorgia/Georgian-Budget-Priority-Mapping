# Georgian Budget - Priority Mapping
Generate a CSV file that indicates which priority a program or agency belongs to for each year on record. This CSV file is used as part of the budget upload process and should be added to the [Georgian Budget Files repo](https://github.com/JumpStartGeorgia/Georgian-Budget-Files).

This script uses the `names_by_year.csv` file from the [Georgian Budget - Unique Names by Year repo](https://github.com/JumpStartGeorgia/Georgian-Budget-Unique-Names-by-Year). The script assumes that the Georgian Budget - Unique Names by Year repo is in a folder at the same level as this repo and the folder name is Georgian-Budget-Unique-Names-by-Year.

To run the script:
* Make sure the `priorities.csv` file has the full list of all the possible priorities ([learn more]())
* Update the `priority_program_mapping.csv` file ([learn more]()) 
* Pull the latest version of the Georgian Budget - Unique Names by Year repo
* From the console type `ruby process_files.rb`
* A file called `priority_associations.csv` will be generated
* Add this file to the [Georgian Budget Files repo](https://github.com/JumpStartGeorgia/Georgian-Budget-Files) in the [files_not_from_government folder](https://github.com/JumpStartGeorgia/Georgian-Budget-Files/tree/master/files_not_from_government)

The `priority_associations.csv` file has the following columns:
* code - the code of the agency/program
* type - indicates whether the item is an agency, program, or sub-program
* name - the name of the program/agency
* priority code - the code of the priority or NA if the program/agency is not assigned to a priority.
* year - the year the record is for


# Priorities.csv - a list of priorities
This is a simple CSV file that lists the possible priorities and a code that represents these priorities. This code is what appears in the generated file `priority_associations.csv` to indicate which priority belongs to a program/agency.

# Priority_Program_Mapping.csv - a list of programs/agencies in each priority
[The Georgia Budget File repo](https://github.com/JumpStartGeorgia/Georgian-Budget-Files) contains a [folder](https://github.com/JumpStartGeorgia/Georgian-Budget-Files/tree/master/files_from_government/priority_pdfs) that lists PDF files that are from the Ministry of Finance that indicate which programs/agencies are assigned to a priority for a given year. 

Unfortunately, these PDF files are not easily parsed by code so this file has to be maintained by hand. When a priority PDF document is released, you will have to go through it and add the program/agency codes to the `priority_program_mapping.csv` file for the new year.