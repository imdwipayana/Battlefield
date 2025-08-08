--CASE

-- add some logic to determine which vendors come on which days
SELECT
	*,
	CASE
		WHEN vendor_type = 'Fresh Focused' THEN 'Wednesday'
		WHEN vendor_type = 'Prepared Foods' THEN 'Thursday'
		ELSE 'Saturday'
	END AS day_of_specialty,
	/*-- pie day, otherwise nothing*/
	
	CASE 
		WHEN vendor_name = "Annie's Pies" THEN 'annie is the best' --- double quotes will work just this once!
	END AS annie_is_the_king,
	
	CASE 
		WHEN vendor_name LIKE '%pie%' THEN 'Wednesday'
		ELSE 'Friday' -- with the else, we get values for FALSE statements
	END AS pie_day,
	-- nonsense, but not a string, instead a different COLUMN
	
	CASE
		WHEN vendor_type = 'Freash Focused' THEN vendor_owner_first_name
		WHEN vendor_type = 'Prepared Foods' THEN vendor_owner_last_name
	END AS first_or_last
FROM vendor
	
	
	 

	
	
	
	
	
	
	
	
	
	
	
	
	
	






