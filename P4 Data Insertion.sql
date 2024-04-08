USE [onlineretail]
GO
OPEN SYMMETRIC KEY passwordEncryptionKey
DECRYPTION BY CERTIFICATE passwordEncryptCertificate;

INSERT INTO Customer (Username, [Password], FirstName, LastName, PhoneNumber, DOB)
VALUES 
('rahul_kumar', EncryptByKey(Key_GUID('passwordEncryptionKey'),'rahul123'), 'Rahul', 'Kumar', '+919876543210', '1990-05-15'), -- India
('neha_patel', EncryptByKey(Key_GUID('passwordEncryptionKey'),'neha456'), 'Neha', 'Patel', '+919876543211', '1992-08-22'), -- India
('john_doe', EncryptByKey(Key_GUID('passwordEncryptionKey'),'john123'), 'John', 'Doe', '+12025551234', '1988-08-20'), -- US
('mary_smith', EncryptByKey(Key_GUID('passwordEncryptionKey'),'mary456'), 'Mary', 'Smith', '+14155551234', '1995-11-12'), -- US
('akash_sharma', EncryptByKey(Key_GUID('passwordEncryptionKey'),'akash789'), 'Akash', 'Sharma', '+919876543212', '1985-11-10'), -- India
('sarah_adams', EncryptByKey(Key_GUID('passwordEncryptionKey'),'sarahpass'), 'Sarah', 'Adams', '+13145551234', '1990-03-18'), -- US
('vikram_jain', EncryptByKey(Key_GUID('passwordEncryptionKey'),'vikram123'), 'Vikram', 'Jain', '+919876543214', '1988-09-18'), -- India
('emily_93', EncryptByKey(Key_GUID('passwordEncryptionKey'),'password'), 'Emily', 'Johnson', '+15559876543', '1993-04-25'), -- US
('priya_singh', EncryptByKey(Key_GUID('passwordEncryptionKey'),'priya1'), 'Priya', 'Singh', '+919876543213', '1993-04-02'), -- India
('james_brown', EncryptByKey(Key_GUID('passwordEncryptionKey'),'james789'), 'James', 'Brown', '+17035551234', '1982-06-30'), -- US
('rahul_gupta', EncryptByKey(Key_GUID('passwordEncryptionKey'),'rahul789'), 'Rahul', 'Gupta', '+919876543216', '1983-06-28'), -- India
('isha_shah', EncryptByKey(Key_GUID('passwordEncryptionKey'),'isha123'), 'Isha', 'Shah', '+919876543217', '1991-10-25'), -- India
('michael_taylor', EncryptByKey(Key_GUID('passwordEncryptionKey'),'michaelpass'), 'Michael', 'Taylor', '+16175551234', '1987-02-10'), -- US
('amit_patil', EncryptByKey(Key_GUID('passwordEncryptionKey'),'amit456'), 'Amit', 'Patil', '+919876543218', '1987-03-19'), -- India
('samantha_wilson', EncryptByKey(Key_GUID('passwordEncryptionKey'),'samanthapass'), 'Samantha', 'Wilson', '+12145551234', '1994-04-28'), -- US
('daniel_thomas', EncryptByKey(Key_GUID('passwordEncryptionKey'),'danielpass'), 'Daniel', 'Thomas', '+14145551234', '1985-01-23'), -- US
('natalie_clark', EncryptByKey(Key_GUID('passwordEncryptionKey'),'nataliepass'), 'Natalie', 'Clark', '+18035551234', '1997-08-03'), -- US
('amanda_jones', EncryptByKey(Key_GUID('passwordEncryptionKey'),'amandapass'), 'Amanda', 'Jones', '+12145551234', '1998-05-06'), -- US
('deepika_verma', EncryptByKey(Key_GUID('passwordEncryptionKey'),'deepika1'), 'Deepika', 'Verma', '+919876543219', '1994-07-07'), -- India
('samantha_silson', EncryptByKey(Key_GUID('passwordEncryptionKey'),'samantha123'),'Samantha','Silson','+1214555124', '1999-08-09'), -- US
('lucas_bennett', EncryptByKey(Key_GUID('passwordEncryptionKey'),'lucas1234'), 'Lucas', 'Bennett', '+12125551234', '1992-01-14'), -- US
('ananya_roy', EncryptByKey(Key_GUID('passwordEncryptionKey'),'ananya4567'), 'Ananya', 'Roy', '+919876543321', '1990-10-22'), -- India
('olivia_harris', EncryptByKey(Key_GUID('passwordEncryptionKey'),'olivia890'), 'Olivia', 'Harris', '+12135551234', '1996-03-18'), -- US
('rohit_sharma', EncryptByKey(Key_GUID('passwordEncryptionKey'),'rohit1234'), 'Rohit', 'Sharma', '+919876543322', '1989-07-16'), -- India
('charlotte_white', EncryptByKey(Key_GUID('passwordEncryptionKey'),'charl789'), 'Charlotte', 'White', '+12045551234', '1997-05-24'), -- US
('manpreet_kaur', EncryptByKey(Key_GUID('passwordEncryptionKey'),'manpreet123'), 'Manpreet', 'Kaur', '+919876543323', '1991-04-30'), -- India
('ethan_wright', EncryptByKey(Key_GUID('passwordEncryptionKey'),'ethan456'), 'Ethan', 'Wright', '+12145551334', '1988-11-09'), -- US
('kriti_malhotra', EncryptByKey(Key_GUID('passwordEncryptionKey'),'kriti789'), 'Kriti', 'Malhotra', '+919876543324', '1986-12-19'), -- India
('isabella_johnson', EncryptByKey(Key_GUID('passwordEncryptionKey'),'isabell123'), 'Isabella', 'Johnson', '+12145551434', '1993-02-28'), -- US
('aditya_kumar', EncryptByKey(Key_GUID('passwordEncryptionKey'),'aditya456'), 'Aditya', 'Kumar', '+919876543325', '1995-08-15'), -- India
('maya_sen', EncryptByKey(Key_GUID('passwordEncryptionKey'),'maya789'), 'Maya', 'Sen', '+919876543326', '1987-09-10'), -- India
('noah_miller', EncryptByKey(Key_GUID('passwordEncryptionKey'),'noah1234'), 'Noah', 'Miller', '+12025551345', '1992-03-21'), -- US
('eva_sharma', EncryptByKey(Key_GUID('passwordEncryptionKey'),'eva1234'), 'Eva', 'Sharma', '+919876543327', '1984-06-13'), -- India
('liam_smith', EncryptByKey(Key_GUID('passwordEncryptionKey'),'liam4567'), 'Liam', 'Smith', '+12045551334', '1990-01-05'), -- US
('nidhi_patel', EncryptByKey(Key_GUID('passwordEncryptionKey'),'nidhi890'), 'Nidhi', 'Patel', '+919876543328', '1993-07-27'), -- India
('mason_king', EncryptByKey(Key_GUID('passwordEncryptionKey'),'mason123'), 'Mason', 'King', '+12135551434', '1996-05-15'), -- US
('aarav_jain', EncryptByKey(Key_GUID('passwordEncryptionKey'),'aarav456'), 'Aarav', 'Jain', '+919876543329', '1994-11-23'), -- India
('mia_hall', EncryptByKey(Key_GUID('passwordEncryptionKey'),'mia789'), 'Mia', 'Hall', '+12125551434', '1995-10-08'), -- US
('priyanka_chopra', EncryptByKey(Key_GUID('passwordEncryptionKey'),'priyanka123'), 'Priyanka', 'Chopra', '+919876543330', '1982-07-18'), -- India
('jacob_lee', EncryptByKey(Key_GUID('passwordEncryptionKey'),'jacob456'), 'Jacob', 'Lee', '+12035551234', '1998-02-26'); -- US



INSERT INTO [Address] (CustomerID, RecipientName, StreetAddress1, StreetAddress2, City, [State], PostalCode, Country)
VALUES 
(1, 'Rahul Kumar', '123 MG Road', 'Flat 101', 'Bengaluru', 'Karnataka', '560001', 'India'),
(2, 'Neha Patel', '47 Patel Nagar', 'Block C', 'Ahmedabad', 'Gujarat', '380008', 'India'),
(3, 'John Doe', '220 B Baker Street', 'Apartment 2B', 'New York', 'NY', '10001', 'USA'),
(4, 'Mary Smith', '742 Evergreen Terrace', 'Suite 300', 'Springfield', 'IL', '62704', 'USA'),
(5, 'Akash Sharma', '55 Jubilee Hills', 'Building B', 'Hyderabad', 'Telangana', '500033', 'India'),
(6, 'Sarah Adams', '1010 Maple Lane', 'Unit 10', 'Chicago', 'IL', '60614', 'USA'),
(7, 'Vikram Jain', '88 M.G. Marg', 'Tower 3', 'Jaipur', 'Rajasthan', '302001', 'India'),
(8, 'Emily Johnson', '321 Pine Street', 'Apartment 5A', 'Philadelphia', 'PA', '19106', 'USA'),
(9, 'Priya Singh', '404 Chembur Place', 'Floor 4', 'Mumbai', 'Maharashtra', '400071', 'India'),
(10, 'James Brown', '12 Ocean View Road', 'Unit 202', 'San Francisco', 'CA', '94121', 'USA'),
(11, 'Rahul Gupta', 'C-2, Sector-15', 'Block D', 'Noida', 'Uttar Pradesh', '201301', 'India'),
(12, 'Isha Shah', '710 Towers', 'Floor 7B', 'Kolkata', 'West Bengal', '700019', 'India'),
(13, 'Michael Taylor', '215 Grand Ave', 'Suite 9', 'Los Angeles', 'CA', '90007', 'USA'),
(14, 'Amit Patil', 'A1, Swarg', 'Building C', 'Pune', 'Maharashtra', '411007', 'India'),
(15, 'Samantha Wilson', '1200 E Broadway', 'Apartment 302', 'Columbia', 'MO', '65201', 'USA'),
(16, 'Daniel Thomas', '800 E Main St', 'Suite 500', 'Richmond', 'VA', '23219', 'USA'),
(17, 'Natalie Clark', '909 Cherry Ave', 'Building A', 'San Jose', 'CA', '95126', 'USA'),
(18, 'Amanda Jones', '50 State Street', 'Suite 700', 'Boston', 'MA', '02109', 'USA'),
(19, 'Deepika Verma', 'D-404, Skyline', 'Block E', 'Gurugram', 'Haryana', '122018', 'India'),
(20, 'Samantha Silson', '100 King Street', 'Building D', 'Seattle', 'WA', '98109', 'USA'),
(21, 'Lucas Bennett', '2500 University Ave', 'Floor 3', 'Des Moines', 'IA', '50311', 'USA'),
(22, 'Ananya Roy', 'G-5, Green Valley', 'Apartment 101', 'Chandigarh', 'Chandigarh', '160019', 'India'),
(23, 'Olivia Harris', '77 Summer St', 'Floor 5', 'Boston', 'MA', '02110', 'USA'),
(24, 'Rohit Sharma', 'Sector 17', 'House 89', 'Chandigarh', 'Chandigarh', '160017', 'India'),
(25, 'Charlotte White', '1821 Jefferson Pl NW', 'Building B', 'Washington', 'DC', '20036', 'USA'),
(26, 'Manpreet Kaur', 'Plot 22, Phase 1', 'Tower 2', 'Mohali', 'Punjab', '160055', 'India'),
(27, 'Ethan Wright', '8th St & Walnut St', 'Unit 10', 'Boulder', 'CO', '80302', 'USA'),
(28, 'Kriti Malhotra', '3rd Cross, JP Nagar', 'Block B', 'Bengaluru', 'Karnataka', '560078', 'India'),
(29, 'Isabella Johnson', '610 Oppenheimer Dr', 'Apartment 250', 'Los Alamos', 'NM', '87544', 'USA'),
(30, 'Aditya Kumar', '7th Avenue', 'Flat 501', 'Mumbai', 'Maharashtra', '400063', 'India'),
(31, 'Maya Sen', 'E-105, Lake Town', 'Block F', 'Kolkata', 'West Bengal', '700089', 'India'),
(32, 'Noah Miller', '2584 Broadway', 'Floor 2', 'New York', 'NY', '10025', 'USA'),
(33, 'Eva Sharma', '12 MG Road', 'Block G', 'Indore', 'Madhya Pradesh', '452001', 'India'),
(34, 'Liam Smith', '3425 Stone Street', 'Building C', 'Austin', 'TX', '78705', 'USA'),
(35, 'Nidhi Patel', '22, Sundar Nagar', 'Block H', 'Rajkot', 'Gujarat', '360005', 'India'),
(36, 'Mason King', '48 Beacon St', 'Apartment 10', 'Boston', 'MA', '02108', 'USA'),
(37, 'Aarav Jain', 'C-56, A/13, Sector-62', 'Block E', 'Noida', 'Uttar Pradesh', '201309', 'India'),
(38, 'Mia Hall', '4209 Lassiter Mill Rd', 'Suite 115', 'Raleigh', 'NC', '27609', 'USA'),
(39, 'Priyanka Chopra', '14 Greenway Terrace', 'Apartment 3B', 'New Delhi', 'Delhi', '110021', 'India'),
(40, 'Jacob Lee', '1178 Broadway', 'Floor 3', 'New York', 'NY', '10001', 'USA');

INSERT INTO Cart (CustomerID) VALUES
(1), -- Rahul Kumar
(2), -- Neha Patel
(3), -- Emily Johnson
(4), -- David Jones
(5), -- Akash Sharma
(6), -- Priya Singh
(7), -- John Doe
(8), -- Mary Smith
(9), -- Vikram Jain
(10), -- Ananya Reddy
(11), -- Sophie Johnson
(12), -- Juan Gomez
(13), -- Rahul Gupta
(14), -- Sarah Adams
(15), -- Robert Clark
(16), -- Isha Shah
(17), -- Amit Patil
(18), -- Daniel Wilson
(19), -- Deepika Verma
(20), -- Samantha Wilson
(21), -- Lucas Bennett
(22), -- Nia Rodriguez
(23), -- Olivia Harris
(24), -- Rohit Sharma
(25), -- Charlotte White
(26), -- Manpreet Kaur
(27), -- Ethan Wright
(28), -- Kriti Malhotra
(29), -- Isabella Johnson
(30), -- Aditya Kumar
(31), -- Maya Sen
(32), -- Noah Miller
(33), -- Eva Sharma
(34), -- Liam Smith
(35), -- Nidhi Patel
(36), -- Mason King
(37), -- Aarav Jain
(38), -- Mia Hall
(39), -- Priyanka Chopra
(40); -- Jacob Lee



INSERT INTO Brand (BrandName, [Description], CompanyInfo) VALUES
('Levi''s', 'Iconic denim brand known for its jeans and casual wear.', 'Levi Strauss & Co. was founded in 1853 in San Francisco.'),
('Nike', 'Global leader in athletic gym, footwear, apparel, and accessories.', 'Nike, Inc. was founded in 1964 by Bill Bowerman and Phil Knight.'),
('Adidas', 'Popular sports brand offering gym wear, apparel, and accessories.', 'Adidas AG was founded in 1949 in Germany by Adolf Dassler.'),
('Gap', 'Casual clothing and accessories brand for men, women, and kids.', 'Gap Inc. was founded in 1969 in San Francisco.'),
('H&M', 'Fashion retailer offering trendy clothing and accessories at affordable prices.', 'H & M Hennes & Mauritz AB was founded in 1947 in Sweden.'),
('Forever 21', 'Fast fashion brand known for its trendy clothing and accessories for young adults.', 'Forever 21, Inc. was founded in 1984 in Los Angeles.'),
('Zara', 'Global fashion retailer offering trendy clothing and accessories for men, women, and kids.', 'Zara is part of Inditex, founded in 1975 in Spain.'),
('Uniqlo', 'Japanese casual wear designer, manufacturer, and retailer.', 'Uniqlo Co., Ltd. was founded in 1949 in Japan.'),
('Old Navy', 'Affordable clothing and accessories brand for the whole family.', 'Old Navy is owned by Gap Inc. and was founded in 1994.'),
('American Eagle Outfitters', 'Casual clothing and accessories brand targeting young adults.', 'American Eagle Outfitters, Inc. was founded in 1977 in Pennsylvania.'),
('Puma', 'Sportswear and athletic shoe brand known for its performance and lifestyle products.', 'Puma SE was founded in 1948 in Germany.'),
('Under Armour', 'American sports clothing and accessories brand specializing in performance apparel.', 'Under Armour, Inc. was founded in 1996 by Kevin Plank.'),
('Lululemon', 'Canadian athletic apparel retailer known for its yoga-inspired clothing.', 'Lululemon Athletica Inc. was founded in 1998 in Vancouver.'),
('GapKids', 'Clothing brand offering casual wear for children.', 'GapKids is a division of Gap Inc., founded in 1969.'),
('Columbia Sportswear', 'Outdoor apparel and accessories brand known for its jackets, sportswear, and outdoor gear.', 'Columbia Sportswear Company was founded in 1938 in Oregon.'),
('The North Face', 'Outdoor recreation product company known for its clothing, footwear, and outdoor equipment.', 'The North Face, Inc. was founded in 1966 in California.'),
('Patagonia', 'Outdoor clothing and gear brand specializing in sustainable and eco-friendly products.', 'Patagonia, Inc. was founded in 1973 in California.'),
('Banana Republic', 'Modern clothing and accessories brand offering versatile and sophisticated apparel.', 'Banana Republic is a division of Gap Inc., founded in 1978.'),
('Abercrombie & Fitch', 'Casual luxury clothing and accessories brand targeting young adults.', 'Abercrombie & Fitch Co. was founded in 1892 in New York.'),
('Tommy Hilfiger', 'American fashion brand offering classic and preppy clothing, accessories, and fragrances.', 'Tommy Hilfiger Corporation was founded in 1985 in New York City.'),
('Mango', 'Spanish clothing design and manufacturing company, offering modern, urban apparel.', 'Mango was founded in 1984 in Barcelona, Spain.'),
('Forever New', 'Fashion clothing and accessories brand known for its effortlessly wearable and timeless collections.', 'Forever New was founded in 2006 in Melbourne, Australia.');



INSERT INTO Category ([Type], [Description], BrandName) VALUES
('Denim', 'High-quality denim jeans and jackets.', 'Levi''s'),--1
('Casual Wear', 'Basic clothing items for everyday wear.', 'Levi''s'),--2
('Fashionable Basics', 'Basic yet trendy clothing items.', 'Levi''s'),--3

('Athletic Gym Wear', 'Gym wear for athletes.', 'Nike'),--4
('Sports wear', 'Apparel for sports and active lifestyles.', 'Nike'),--5
('Youth Fashion', 'Fashion-forward apparel targeting young adults.', 'Nike'),--6

('Sportswear', 'Apparel for sports and active lifestyles.', 'Adidas'),--7
('Everyday wear', ' Everyday comfort wear and lifestyles.', 'Adidas'),--8
('Loungewear', 'Everyday sleep wear.', 'Adidas'),--9
('Outerwear', 'Jackets, coats for warmth and protection.', 'Adidas'),--10

('Casual Wear', 'Everyday clothes for men, women, and children.', 'Gap'),--11
('Dresses & Jumpsuits', 'Effortlessly chic dresses and jumpsuits for various occasions.', 'Gap'),--12
('Sweaters & Cardigans', 'Cozy and stylish sweaters and cardigans for layering.', 'Gap'),--13
('Outerwear', 'Stylish and functional outerwear pieces to stay cozy in cooler weather.', 'Gap'),--14
('Denim', 'Classic and durable denim options for a timeless look.', 'Gap'),--15

('Fast Fashion', 'Trendy fashion items at affordable prices.', 'H&M'),--16
('Outerwear', 'Trendy outerwear pieces to keep you warm and stylish.', 'H&M'),--17
('Activewear', 'Functional and stylish activewear to keep you motivated during workouts.', 'H&M'),--18
('Dresses', 'Chic and elegant dresses for any event or outing.', 'H&M'),--19
('Loungewear', 'Cozy and relaxed loungewear perfect for chilling at home.', 'H&M'),--20
('Swimwear', 'Vibrant and flattering swimwear for fun days by the water.', 'H&M'),--21
('Formal Wear', 'Attire suitable for formal occasions, such as business meetings or weddings.', 'H&M'),--22

('Youth Fashion', 'Fashion-forward apparel targeting young adults.', 'Forever 21'),--23
('Parywear', 'Fashion-forward partywear targeting young adults.', 'Forever 21'),--24
('Business Attire', 'Professional clothing suitable for office settings.', 'Forever 21'),--25
('Casual Clothing', 'Relaxed and comfortable clothing for everyday wear.', 'Forever 21'),--26
('Outerwear', 'Stylish jackets and coats for protection against the elements.', 'Forever 21'),--27


('European Fashion', 'Contemporary clothing influenced by European styles.', 'Zara'),--28
('Casual Wear', 'Stylish and comfortable clothing for casual occasions.', 'Zara'),--29
('Formal Wear', 'Elegant and sophisticated attire for formal events.', 'Zara'),--30
('Streetwear', 'Trendy and urban-inspired clothing for the modern individual.', 'Zara'),--31
('Workwear', 'Chic and professional outfits for the workplace.', 'Zara'),--32
('Outerwear', 'Fashionable and functional jackets and coats.', 'Zara'),--33
('Activewear', 'Sporty and stylish athletic wear for active lifestyles.', 'Zara'),--34
('Swimwear', 'Stylish swimwear for enjoying sunny days by the water.', 'Zara'),--35


('Japanese Casual', 'Minimalist and functional casual wear.', 'Uniqlo'),--36
('Everyday Wear', 'Simple yet stylish clothing for everyday comfort.', 'Uniqlo'),--37
('Athleisure', 'Versatile activewear suitable for both exercise and casual wear.', 'Uniqlo'),--38
('Casual Basics', 'High-quality wardrobe essentials for effortless style.', 'Uniqlo'),--39
('Outerwear', 'Functional and stylish jackets and coats for various weather conditions.', 'Uniqlo'),--40
('Denim', 'Durable and comfortable denim pieces for a casual look.', 'Uniqlo'),--41
('Workwear', 'Practical and comfortable clothing suitable for the workplace.', 'Uniqlo'),--42
('Basics & Essentials', 'Versatile basics that form the foundation of any wardrobe.', 'Uniqlo'),--43


('Family Apparel', 'Clothing options for the whole family.', 'Old Navy'),--44
('Activewear', 'Functional and stylish activewear for men, women, and children.', 'Old Navy'),--45
('Loungewear', 'Comfortable and relaxed loungewear for leisure.', 'Old Navy'),--46
('Denim', 'Classic denim jeans and jackets for everyday wear.', 'Old Navy'),--47
('Outerwear', 'Stylish jackets and coats to keep you warm in colder weather.', 'Old Navy'),--48

('Everyday Essentials', 'Basic clothing items for everyday wear.', 'American Eagle Outfitters'),--49
('Graphic Tees', 'Trendy and expressive graphic t-shirts.', 'American Eagle Outfitters'),--50
('Jeans', 'Fashionable jeans for men and women.', 'American Eagle Outfitters'),--51
('Sweatshirts & Hoodies', 'Cozy sweatshirts and hoodies for casual comfort.', 'American Eagle Outfitters'),--52
('Teen Apparel', 'Casual and trendy clothes for teenagers.', 'American Eagle Outfitters'),--53

('Athletic Gear', 'Sports equipment and athletic wear.', 'Puma'),--54
('Loungewear', 'Comfortable and relaxed loungewear for leisure.', 'Puma'),--55
('Sports tops & Leggings', 'Comfortable and supportive activewear for women.', 'Puma'),--56

('Performance Apparel', 'High-performance sports clothing.', 'Under Armour'),--57
('Loungewear', 'Comfortable and relaxed loungewear for leisure.', 'Under Armour'),--58
('Sports tops & Leggings', 'Comfortable and supportive activewear for women.', 'Under Armour'),--59
('Training Apparel', 'Apparel designed for high-intensity training sessions.', 'Under Armour'),--60
('Compression Wear', 'Compression clothing for improved performance and recovery.', 'Under Armour'),--61

('Yoga Clothing', 'Activewear specifically designed for yoga.', 'Lululemon'),--62
('Leggings & Tights', 'Comfortable and stylish leggings for workouts and everyday wear.', 'Lululemon'),--63
('Sports wear', 'Supportive and stylish sports wear for women.', 'Lululemon'),--64

('Children''s Casual', 'Fun and comfortable clothing for kids.', 'GapKids'),--65
('Playwear', 'Fun and durable clothing for active kids.', 'GapKids'),--66
('School Uniforms', 'Classic and comfortable uniforms for school.', 'GapKids'),--67
('Pajamas', 'Cozy pajama sets for bedtime.', 'GapKids'),--68
('Swimwear', 'Colorful and playful swimwear for kids.', 'GapKids'),--69

('Hiking Apparel', 'Apparel designed for hiking and outdoor adventures.', 'Columbia Sportswear'),--70
('Outdoor Clothing', 'Apparel for outdoor activities and adventures.', 'Columbia Sportswear'),--71
('Fishing Apparel', 'Functional and durable clothing for fishing enthusiasts.', 'Columbia Sportswear'),--72
('Rainwear', 'Waterproof jackets and pants to keep you dry in rainy conditions.', 'Columbia Sportswear'),--73
('Loungewear', 'Comfortable and relaxed loungewear for leisure.', 'Columbia Sportswear'),--74

('Adventure Gear', 'Equipment and clothing for exploring the outdoors.', 'The North Face'),--75
('Hiking Apparel', 'Apparel designed for hiking and outdoor adventures.', 'The North Face'),--76
('Fishing Apparel', 'Functional and durable clothing for fishing enthusiasts.', 'The North Face'),--77
('Rainwear', 'Waterproof jackets and pants to keep you dry in rainy conditions.', 'The North Face'),--78
('Fleece Jackets', 'Warm and versatile fleece jackets for outdoor activities.', 'The North Face'),--79

('Eco-Friendly Apparel', 'Sustainable clothing made from eco-friendly materials.', 'Patagonia'),--80
('Outerwear', 'Stylish and functional jackets and vests for outdoor adventures.', 'Patagonia'),--81

('Sophisticated Casual', 'Elegant and versatile clothing for modern adults.', 'Banana Republic'),--82
('Professional Attire', 'Stylish and professional clothing for the workplace.', 'Banana Republic'),--83
('Tailored Elegance', 'High-quality suits tailored for a perfect fit.', 'Banana Republic'),--84
('Eventwear', 'Elegant dresses for various occasions.', 'Banana Republic'),--85
('Sophisticated Tops', 'Chic blouses and shirts for a polished look.', 'Banana Republic'),--86

('Casual Essentials', 'Casual and trendy tops for everyday wear.', 'Abercrombie & Fitch'),--87
('Young Adult Fashion', 'Stylish and casual clothing for young adults.', 'Abercrombie & Fitch'),--88
('Denim Delights', 'Fashionable jeans and bottoms for various occasions.', 'Abercrombie & Fitch'),--89
('Outerwear Style', 'Stylish jackets and coats for cooler weather.', 'Abercrombie & Fitch'),--90
('Feminine Chic', 'Chic dresses and jumpsuits for a feminine look.', 'Abercrombie & Fitch'),--91

('Preppy Apparel', 'Classic preppy clothing and accessories.', 'Tommy Hilfiger'),--92
('Classic Polos', 'Iconic polo shirts with timeless appeal.', 'Tommy Hilfiger'),--93
('Versatile Bottoms', 'Versatile chinos and shorts for a casual yet polished look.', 'Tommy Hilfiger'),--94
('Cozy Knits', 'Cozy sweaters and cardigans for layering.', 'Tommy Hilfiger'),--95
('Sophisticated Dresses', 'Stylish dresses for various occasions.', 'Tommy Hilfiger'),--96

('Casual Tops', 'Stylish tops for everyday casual wear.', 'Mango'),--97
('Layering Essentials', 'Trendy blazers and jackets to layer up in style.', 'Mango'),--98
('Chic Dresses', 'Chic dresses for any event or outing.', 'Mango'),--99
('Denim Delights', 'Fashionable denim options for a casual yet trendy look.', 'Mango'),--100
('Formal Wear', 'Elegant and sophisticated attire for formal events.', 'Mango'),--101

('Timeless Classics', 'Elegant and timeless clothing options.', 'Forever New'),--102
('Feminine Tops', 'Stylish tops and blouses for everyday wear.', 'Forever New'),--103
('Skirts & Shorts', 'Chic skirts and shorts for a feminine look.', 'Forever New'),--104
('Elegant Dresses', 'Elegant dresses for various occasions.', 'Forever New'),--105
('Outerwear Glamour', 'Stylish coats and jackets to keep you warm in colder weather.', 'Forever New');--106
 

INSERT INTO Product (BrandID, CategoryID, Price, [Description], ProductName) VALUES
(1, 1, 49.99, 'Timeless denim jeans for everyday wear.', 'Classic Denim Jeans'), -- Levi's Denim
(1, 1, 79.99, 'Classic denim jacket for versatile styling.', 'Basic Denim Jacket'), -- Levi's Denim
(1, 2, 19.99, 'Comfortable cotton t-shirt for everyday wear.', 'Casual Cotton T-shirt'), -- Levi's Casual Wear
(1, 2, 39.99, 'Cozy hoodie for casual comfort.', 'Essential Hoodie'), -- Levi's Casual Wear
(1, 3, 14.99, 'Basic t-shirt suitable for everyday use.', 'Everyday Basic T-shirt'), -- Levi's Fashionable Basics

(2, 4, 29.99, 'Performance shorts for athletic activities.', 'Sports Performance Shorts'), -- Nike Athletic Gym Wear
(2, 5, 99.99, 'High-quality running shorts for athletes.', 'Running Shorts'), -- Nike Sports wear
(2, 6, 79.99, 'Stylish sneakers for young adults.', 'Fashionable Sneakers'), -- Nike Youth Fashion

(3, 7, 39.99, 'Comfortable leggings for workouts.', 'Training Leggings'), -- Adidas Sportswear
(3, 8, 49.99, 'Casual joggers for everyday wear.', 'Everyday Joggers'), -- Adidas Everyday wear
(3, 9, 59.99, 'Soft loungewear set for relaxing at home.', 'Cozy Loungewear Set'), -- Adidas Loungewear
(3, 10, 89.99, 'Stylish jacket for outdoor adventures.', 'Waterproof Jacket'), -- Adidas Outerwear

(4, 11, 29.99, 'Essential sweatshirt for everyday use.', 'Classic Crewneck Sweatshirt'), -- Gap Casual Wear
(4, 12, 69.99, 'Stylish dress suitable for various occasions.', 'Chic Wrap Dress'), -- Gap Dresses & Jumpsuits
(4, 13, 49.99, 'Cozy sweater for layering in cooler weather.', 'Warm Knit Sweater'), -- Gap Sweaters & Cardigans
(4, 14, 79.99, 'Stylish puffer jacket for chilly days.', 'Quilted Puffer Jacket'), -- Gap Outerwear
(4, 15, 59.99, 'Modern slim fit jeans for a stylish look.', 'Slim Fit Jeans'), -- Gap Denim

(5, 16, 19.99, 'Fashionable graphic t-shirt for a casual vibe.', 'Trendy Graphic T-shirt'), -- H&M Fast Fashion
(5, 17, 69.99, 'Trendy bomber jacket for a fashionable look.', 'Stylish Bomber Jacket'), -- H&M Outerwear
(5, 18, 34.99, 'Comfortable leggings for yoga practice.', 'Yoga Leggings'), -- H&M Activewear
(5, 19, 89.99, 'Sophisticated dress for special occasions.', 'Elegant Evening Dress'), -- H&M Dresses
(5, 20, 49.99, 'Soft lounge set for ultimate comfort.', 'Cozy Lounge Set'), -- H&M Loungewear
(5, 21, 39.99, 'Vibrant swimsuit for fun beach days.', 'Floral Print Swimsuit'), -- H&M Swimwear
(5, 22, 99.99, 'Classic blazer for formal events.', 'Formal Blazer'), -- H&M Formal Wear

(6, 23, 49.99, 'Stylish hoodie for a trendy streetwear look.', 'Trendy Streetwear Hoodie'), -- Forever 21 Youth Fashion
(6, 24, 59.99, 'Eye-catching dress for party nights.', 'Sequin Party Dress'), -- Forever 21 Parywear
(6, 25, 79.99, 'Smart blazer for office wear.', 'Professional Blazer'), -- Forever 21 Business Attire
(6, 26, 39.99, 'Comfortable jeans for casual outings.', 'Relaxed Fit Jeans'), -- Forever 21 Casual Clothing
(6, 27, 89.99, 'Fashionable parka for protection from the elements.', 'Stylish Parka'), -- Forever 21 Outerwear

(7, 28, 79.99, 'Elegant dress with European-inspired design.', 'Chic European Dress'), -- Zara European Fashion
(7, 29, 49.99, 'Versatile pants for everyday casual wear.', 'Comfortable Casual Pants'), -- Zara Casual Wear
(7, 30, 199.99, 'Classic suit for formal events.', 'Sophisticated Formal Suit'), -- Zara Formal Wear
(7, 31, 89.99, 'Stylish jacket for urban-inspired looks.', 'Trendy Streetwear Jacket'), -- Zara Streetwear
(7, 32, 69.99, 'Chic dress suitable for office wear.', 'Professional Office Dress'), -- Zara Workwear
(7, 33, 99.99, 'Trendy outerwear piece for any occasion.', 'Fashionable Outerwear'), -- Zara Outerwear
(7, 34, 79.99, 'Functional jacket for sports activities.', 'Sporty Running Jacket'), -- Zara Activewear
(7, 35, 34.99, 'Stylish bikini for beach outings.', 'Floral Print Bikini'), -- Zara Swimwear

(8, 36, 39.99, 'Simple yet stylish shirt with Japanese design.', 'Minimalist Japanese Shirt'), -- Uniqlo Japanese Casual
(8, 37, 14.99, 'Essential t-shirt for everyday wear.', 'Basic Crewneck T-shirt'), -- Uniqlo Everyday Wear
(8, 38, 29.99, 'Comfortable pants designed for yoga practice.', 'Stretchy Yoga Pants'), -- Uniqlo Athleisure
(8, 39, 24.99, 'Basic shirt suitable for various casual looks.', 'Versatile Cotton Shirt'), -- Uniqlo Casual Basics
(8, 40, 59.99, 'Functional raincoat for rainy weather.', 'Waterproof Raincoat'), -- Uniqlo Outerwear
(8, 41, 49.99, 'Modern slim fit jeans for casual style.', 'Slim Fit Denim Jeans'), -- Uniqlo Denim
(8, 42, 34.99, 'Professional blouse for workplace attire.', 'Smart Office Blouse'), -- Uniqlo Workwear
(8, 43, 9.99, 'Versatile t-shirt suitable for any outfit.', 'Basic Cotton T-shirt'), -- Uniqlo Basics & Essentials


(9, 44, 29.99, 'Matching t-shirts for the whole family.', 'Family Matching T-shirts'), -- Old Navy Family Apparel
(9, 45, 39.99, 'Functional activewear set for kids.', 'Kids Activewear Set'), -- Old Navy Activewear
(9, 46, 24.99, 'Soft loungewear set for kids.', 'Cozy Kids Loungewear'), -- Old Navy Loungewear
(9, 47, 39.99, 'Durable denim jacket for kids.', 'Classic Kids Denim Jacket'), -- Old Navy Denim
(9, 48, 79.99, 'Stylish parka for warmth and style.', 'Warm Kids Parka'), -- Old Navy Outerwear

(10, 49, 12.99, 'Versatile t-shirt for everyday wear.', 'Essential Basic T-shirt'), -- American Eagle Outfitters Everyday Essentials
(10, 50, 24.99, 'Expressive graphic t-shirt for a trendy look.', 'Graphic Print Tee'), -- American Eagle Outfitters Graphic Tees
(10, 51, 59.99, 'Fashionable skinny jeans for a sleek look.', 'Stylish Skinny Jeans'), -- American Eagle Outfitters Jeans
(10, 52, 44.99, 'Cozy hooded sweatshirt for casual comfort.', 'Comfy Hooded Sweatshirt'), -- American Eagle Outfitters Sweatshirts & Hoodies
(10, 53, 49.99, 'Fashionable jumpsuit for teenagers.', 'Trendy Teen Jumpsuit'), -- American Eagle Outfitters Teen Apparel

(11, 54, 119.99, 'High-performance running shorts for athletes.', 'Professional Running Shorts'), -- Puma Athletic Gear
(11, 55, 59.99, 'Relaxed hoodie for leisure wear.', 'Cozy Lounge Hoodie'), -- Puma Loungewear
(11, 56, 34.99, 'Comfortable sports bra for active women.', 'Supportive Sports Bra'), -- Puma Sports tops & Leggings

(12, 57, 44.99, 'Stylish training tights for workouts.', 'Sleek Training Tights'), -- Under Armour Sports tops & Leggings
(12, 58, 49.99, 'Cozy sweatpants for lounging.', 'Soft Lounge Sweatpants'), -- Under Armour Loungewear
(12, 59, 39.99, 'Fashionable leggings for everyday wear.', 'Stylish Womens Leggings'), -- Under Armour Sports tops & Leggings
(12, 60, 34.99, 'Functional shorts for intense workouts.', 'High-Intensity Training Shorts'), -- Under Armour Training Apparel
(12, 61, 59.99, 'Compression leggings for improved performance.', 'Compression Leggings'), -- Under Armour Compression Wear

(13, 62, 79.99, 'Soft and stretchy leggings for yoga.', 'Comfortable Yoga Leggings'), -- Lululemon Yoga Clothing
(13, 64, 54.99, 'Comfortable and supportive sports bra.', 'Supportive Sports Bra'), -- Lululemon Sports wear

(14, 65, 39.99, 'Fun and comfortable set for kids.', 'Playful Kids Casual Set'), -- GapKids Children's Casual
(14, 67, 49.99, 'Traditional uniform for school.', 'Classic School Uniform'), -- GapKids School Uniforms
(14, 68, 29.99, 'Soft pajama set for a good nights sleep.', 'Cozy Kids Pajama Set'), -- GapKids Pajamas
(14, 69, 24.99, 'Vibrant swimwear for kids.', 'Colorful Kids Swimwear'), -- GapKids Swimwear

(15, 70, 69.99, 'Functional pants for hiking adventures.', 'Durable Hiking Pants'), -- Columbia Sportswear Hiking Apparel
(15, 71, 99.99, 'Stylish jacket for outdoor activities.', 'Outdoor Adventure Jacket'), -- Columbia Sportswear Outdoor Clothing
(15, 72, 49.99, 'Functional shorts for fishing.', 'Durable Fishing Shorts'), -- Columbia Sportswear Fishing Apparel
(15, 73, 89.99, 'Functional rain jacket for wet weather.', 'Waterproof Rain Jacket'), -- Columbia Sportswear Rainwear
(15, 74, 54.99, 'Comfortable loungewear set for relaxation.', 'Relaxed Lounge Set'), -- Columbia Sportswear Loungewear

(16, 76, 79.99, 'Functional pants for hiking adventures.', 'Versatile Hiking Pants'), -- The North Face Hiking Apparel
(16, 76, 119.99, 'Fashionable jacket for outdoor activities.', 'Stylish Outdoor Jacket'), -- The North Face Outdoor Clothing
(16, 77, 64.99, 'Functional pants for fishing.', 'Durable Fishing Pants'), -- The North Face Fishing Apparel
(16, 78, 69.99, 'Functional rain pants for wet weather.', 'Waterproof Rain Pants'), -- The North Face Rainwear
(16, 79, 89.99, 'Cozy fleece jacket for outdoor warmth.', 'Warm Fleece Jacket'), -- The North Face Fleece Jackets

(17, 80, 149.99, 'Sustainable jacket for outdoor adventures.', 'Eco-Friendly Outdoor Jacket'), -- Patagonia Eco-Friendly Apparel
(17, 81, 79.99, 'Fashionable vest for outdoor style.', 'Stylish Vest'), -- Patagonia Outerwear

(18, 82, 129.99, 'Elegant blazer for professional attire.', 'Sophisticated Blazer'), -- Banana Republic Sophisticated Casual
(18, 83, 99.99, 'Classic dress suitable for office wear.', 'Formal Office Dress'), -- Banana Republic Professional Attire
(18, 84, 299.99, 'High-quality suit tailored for a perfect fit.', 'Tailored Suit'), -- Banana Republic Tailored Elegance
(18, 85, 199.99, 'Stylish gown for evening events.', 'Chic Evening Gown'), -- Banana Republic Eventwear
(18, 86, 59.99, 'Sophisticated shirt for a polished look.', 'Polished Button-up Shirt'), -- Banana Republic Sophisticated Tops

(19, 87, 29.99, 'Stylish t-shirt for everyday wear.', 'Trendy Casual T-shirt'), -- Abercrombie & Fitch Casual Essentials
(19, 88, 49.99, 'Comfortable hoodie for young adults.', 'Youthful Hoodie'), -- Abercrombie & Fitch Young Adult Fashion
(19, 89, 69.99, 'Trendy skinny jeans for various occasions.', 'Fashionable Skinny Jeans'), -- Abercrombie & Fitch Denim Delights
(19, 90, 129.99, 'Fashionable coat for colder weather.', 'Stylish Winter Coat'), -- Abercrombie & Fitch Outerwear Style
(19, 91, 89.99, 'Sophisticated midi dress for a feminine look.', 'Elegant Midi Dress'), -- Abercrombie & Fitch Feminine Chic

(20, 92, 44.99, 'Classic polo shirt with preppy style.', 'Preppy Polo Shirt'), -- Tommy Hilfiger Preppy Apparel
(20, 94, 59.99, 'Versatile chino pants for various outfits.', 'Classic Chino Pants'), -- Tommy Hilfiger Classic Polos
(20, 95, 69.99, 'Warm and cozy sweater for layering.', 'Cozy Knit Sweater'), -- Tommy Hilfiger Cozy Knits
(20, 96, 99.99, 'Elegant A-line dress for various occasions.', 'Sophisticated A-Line Dress'), -- Tommy Hilfiger Sophisticated Dresses

(21, 97, 39.99, 'Chic blouse for everyday casual wear.', 'Stylish Casual Blouse'), -- Mango Casual Tops
(21, 98, 79.99, 'Fashionable jacket for stylish layering.', 'Trendy Layering Jacket'), -- Mango Layering Essentials
(21, 99, 69.99, 'Stylish dress with a floral design.', 'Chic Floral Dress'), -- Mango Chic Dresses
(21, 100, 89.99, 'Trendy distressed denim jeans for a fashionable look.', 'Distressed Denim Jeans'), -- Mango Denim Delights
(21, 101, 149.99, 'Sophisticated gown for formal events.', 'Elegant Evening Gown'), -- Mango Formal Wear

(22, 102, 119.99, 'Elegant lace dress for timeless appeal.', 'Timeless Lace Dress'), -- Forever New Timeless Classics
(22, 103, 79.99, 'Chic blouse with feminine ruffle details.', 'Feminine Ruffle Blouse'), -- Forever New Feminine Tops
(22, 104, 49.99, 'Playful mini skirt with a floral print.', 'Floral Print Mini Skirt'), -- Forever New Skirts & Shorts
(22, 105, 179.99, 'Elegant maxi dress for special occasions.', 'Graceful Maxi Dress'), -- Forever New Elegant Dresses
(22, 106, 199.99, 'Stylish wool coat for winter warmth.', 'Chic Wool Coat'); -- Forever New Outerwear Glamour

INSERT INTO Inventory (Quantity, [Size], Color)
VALUES 
(50, 'S', 'Blue'),
(50, 'M', 'Blue'),
(50, 'L', 'Blue'),
(50, 'XL', 'Blue'),
(50, 'XXL', 'Blue'),
(100, 'S', 'Black'),
(100, 'M', 'Black'),
(100, 'L', 'Black'),
(100, 'S', 'Red'),
(100, 'M', 'Red'),
(100, 'L', 'Red'),
(100, 'S', 'Silver'),
(100, 'M', 'Silver'),
(100, 'L', 'Silver'),
(100, 'S', 'Gray'),
(100, 'M', 'Gray'),
(100, 'L', 'Gray'),
(100, 'S', 'Green'),
(100, 'M', 'Green'),
(100, 'L', 'Green'),
(50, 'XL', 'White'),
(50, 'XXL', 'White'),
(50, 'S', 'Black'),
(50, 'M', 'Black'),
(50, 'L', 'Black'),
(100, 'XL', 'Navy'),
(100, 'XXL', 'Navy'),
(100, 'S', 'Pink'),
(100, 'M', 'Pink'),
(100, 'L', 'Pink'),
(100, 'S', 'Gold'),
(100, 'M', 'Gold'),
(100, 'L', 'Gold'),
(100, 'S', 'Purple'),
(100, 'M', 'Purple'),
(100, 'L', 'Purple'),
(100, 'S', 'Yellow'),
(100, 'M', 'Yellow'),
(100, 'L', 'Yellow'),
(200, 'XL', 'Brown'),
(200, 'XXL', 'Brown'),
(200, 'S', 'Cyan'),
(200, 'M', 'Cyan'),
(200, 'L', 'Cyan'),
(200, 'XL', 'Cyan'),
(200, 'XXL', 'Cyan'),
(150, 'S', 'Maroon'),
(150, 'M', 'Maroon'),
(150, 'L', 'Maroon'),
(150, 'XL', 'Maroon'),
(150, 'XXL', 'Maroon'),
(150, 'S', 'Olive'),
(150, 'M', 'Olive'),
(150, 'L', 'Olive'),
(150, 'XL', 'Olive'),
(150, 'XXL', 'Olive'),
(200, 'S', 'Turquoise'),
(200, 'M', 'Turquoise'),
(200, 'L', 'Turquoise'),
(200, 'XL', 'Turquoise'),
(200, 'XXL', 'Turquoise'),
(100, 'S', 'Teal'),
(100, 'M', 'Teal'),
(100, 'L', 'Teal'),
(100, 'XL', 'Teal'),
(100, 'XXL', 'Teal'),
(100, 'S', 'Indigo'),
(100, 'M', 'Indigo'),
(100, 'L', 'Indigo'),
(100, 'XL', 'Indigo'),
(100, 'XXL', 'Indigo'),
(150, 'S', 'Magenta'),
(150, 'M', 'Magenta'),
(150, 'L', 'Magenta'),
(150, 'XL', 'Magenta'),
(150, 'XXL', 'Magenta'),
(150, 'S', 'Lavender'),
(150, 'M', 'Lavender'),
(150, 'L', 'Lavender'),
(150, 'XL', 'Lavender'),
(150, 'XXL', 'Lavender'),
(100, 'S', 'Beige'),
(100, 'M', 'Beige'),
(100, 'L', 'Beige'),
(100, 'XL', 'Beige'),
(100, 'XXL', 'Beige'),
(200, 'S', 'Peach'),
(200, 'M', 'Peach'),
(200, 'L', 'Peach'),
(200, 'XL', 'Peach'),
(200, 'XXL', 'Peach'),
(150, 'S', 'Coral'),
(150, 'M', 'Coral'),
(150, 'L', 'Coral'),
(150, 'XL', 'Coral'),
(150, 'XXL', 'Coral'),
(150, 'S', 'Salmon'),
(150, 'M', 'Salmon'),
(150, 'L', 'Salmon'),
(150, 'XL', 'Salmon'),
(150, 'XXL', 'Salmon'),
(100, 'S', 'Sky Blue'),
(100, 'M', 'Sky Blue'),
(100, 'L', 'Sky Blue'),
(100, 'XL', 'Sky Blue');


INSERT INTO InventoryProduct (InventoryID, ProductID, [Location], BatchNumber) VALUES
(1, 1, 'Warehouse A', 'INV12345'),
(2, 2, 'Warehouse B', 'INV12346'),
(3, 3, 'Warehouse C', 'INV12347'),
(4, 4, 'Warehouse D', 'INV12348'),
(5, 5, 'Warehouse E', 'INV12349'),
(6, 6, 'Warehouse A', 'INV12350'),
(7, 7, 'Warehouse B', 'INV12351'),
(8, 8, 'Warehouse C', 'INV12352'),
(9, 9, 'Warehouse A', 'INV12353'),
(10, 10, 'Warehouse B', 'INV12354'),
(11, 11, 'Warehouse C', 'INV12355'),
(12, 12, 'Warehouse A', 'INV12356'),
(13, 13, 'Warehouse B', 'INV12357'),
(14, 14, 'Warehouse C', 'INV12358'),
(15, 15, 'Warehouse A', 'INV12359'),
(16, 16, 'Warehouse B', 'INV12360'),
(17, 17, 'Warehouse C', 'INV12361'),
(18, 18, 'Warehouse A', 'INV12362'),
(19, 19, 'Warehouse B', 'INV12363'),
(20, 20, 'Warehouse C', 'INV12364'),
(21, 21, 'Warehouse A', 'INV12365'),
(22, 22, 'Warehouse B', 'INV12366'),
(23, 23, 'Warehouse C', 'INV12367'),
(24, 24, 'Warehouse A', 'INV12368'),
(25, 25, 'Warehouse B', 'INV12369'),
(26, 26, 'Warehouse C', 'INV12370'),
(27, 27, 'Warehouse A', 'INV12371'),
(28, 28, 'Warehouse B', 'INV12372'),
(29, 29, 'Warehouse C', 'INV12373'),
(30, 30, 'Warehouse A', 'INV12374'),
(31, 31, 'Warehouse B', 'INV12375'),
(32, 32, 'Warehouse C', 'INV12376'),
(33, 33, 'Warehouse A', 'INV12377'),
(34, 34, 'Warehouse B', 'INV12378'),
(35, 35, 'Warehouse C', 'INV12379'),
(36, 36, 'Warehouse A', 'INV12380'),
(37, 37, 'Warehouse B', 'INV12381'),
(38, 38, 'Warehouse C', 'INV12382'),
(39, 39, 'Warehouse A', 'INV12383'),
(40, 40, 'Warehouse B', 'INV12384'),
(41, 41, 'Warehouse C', 'INV12385'),
(42, 42, 'Warehouse A', 'INV12386'),
(43, 43, 'Warehouse B', 'INV12387'),
(44, 44, 'Warehouse C', 'INV12388'),
(45, 45, 'Warehouse A', 'INV12389'),
(46, 46, 'Warehouse B', 'INV12390'),
(47, 47, 'Warehouse C', 'INV12391'),
(48, 48, 'Warehouse A', 'INV12392'),
(49, 49, 'Warehouse B', 'INV12393'),
(50, 50, 'Warehouse C', 'INV12394'),
(51, 51, 'Warehouse A', 'INV12395'),
(52, 52, 'Warehouse B', 'INV12396'),
(53, 53, 'Warehouse C', 'INV12397'),
(54, 54, 'Warehouse A', 'INV12398'),
(55, 55, 'Warehouse B', 'INV12399'),
(56, 56, 'Warehouse C', 'INV12400'),
(57, 57, 'Warehouse A', 'INV12401'),
(58, 58, 'Warehouse B', 'INV12402'),
(59, 59, 'Warehouse C', 'INV12403'),
(60, 60, 'Warehouse A', 'INV12404'),
(61, 61, 'Warehouse B', 'INV12405'),
(62, 62, 'Warehouse C', 'INV12406'),
(63, 63, 'Warehouse A', 'INV12407'),
(64, 64, 'Warehouse B', 'INV12408'),
(65, 65, 'Warehouse C', 'INV12409'),
(66, 66, 'Warehouse A', 'INV12410'),
(67, 67, 'Warehouse B', 'INV12411'),
(68, 68, 'Warehouse C', 'INV12412'),
(69, 69, 'Warehouse A', 'INV12413'),
(70, 70, 'Warehouse B', 'INV12414'),
(71, 71, 'Warehouse C', 'INV12415'),
(72, 72, 'Warehouse A', 'INV12416'),
(73, 73, 'Warehouse B', 'INV12417'),
(74, 74, 'Warehouse C', 'INV12418'),
(75, 75, 'Warehouse A', 'INV12419'),
(76, 76, 'Warehouse B', 'INV12420'),
(77, 77, 'Warehouse C', 'INV12421'),
(78, 78, 'Warehouse A', 'INV12422'),
(79, 79, 'Warehouse B', 'INV12423'),
(80, 80, 'Warehouse C', 'INV12424'),
(81, 81, 'Warehouse A', 'INV12425'),
(82, 82, 'Warehouse B', 'INV12426'),
(83, 83, 'Warehouse C', 'INV12427'),
(84, 84, 'Warehouse A', 'INV12428'),
(85, 85, 'Warehouse B', 'INV12429'),
(86, 86, 'Warehouse C', 'INV12430'),
(87, 87, 'Warehouse A', 'INV12431'),
(88, 88, 'Warehouse B', 'INV12432'),
(89, 89, 'Warehouse C', 'INV12433'),
(90, 90, 'Warehouse A', 'INV12434'),
(91, 91, 'Warehouse B', 'INV12435'),
(92, 92, 'Warehouse C', 'INV12436'),
(93, 93, 'Warehouse A', 'INV12437'),
(94, 94, 'Warehouse B', 'INV12438'),
(95, 95, 'Warehouse C', 'INV12439'),
(96, 96, 'Warehouse A', 'INV12440'),
(97, 97, 'Warehouse B', 'INV12441'),
(98, 98, 'Warehouse C', 'INV12442'),
(99, 99, 'Warehouse A', 'INV12443'),
(100, 100, 'Warehouse B', 'INV12444'),
(101, 101, 'Warehouse C', 'INV12445'),
(102, 102, 'Warehouse A', 'INV12446'),
(103, 103, 'Warehouse B', 'INV12447'),
(104, 104, 'Warehouse C', 'INV12448'),
(105, 105, 'Warehouse A', 'INV12449');

INSERT INTO CartItem (CartID, ProductID, [Size], Discount, Quantity) VALUES
(1, 2, 'S', 0.00, 2),
(1, 7, 'M', 3.00, 1),
(1, 1, 'L', 0.00, 2),
(1, 4, 'XL', 0.00, 3),
(1, 5, 'XXL', 0.00, 4),
(2, 27,'S', 5.00, 1),
(2, 56,'M', 5.00, 5),
(2, 42, 'L', 5.00, 3),
(3, 23, 'XL', 10.00, 1),
(4, 14, 'S', 0.00, 2),
(4, 54,'L', 4.00, 1),
(4, 36,'M', 0.00, 2),
(5, 15, 'XXL', 0.00, 1),
(5, 35, 'S', 3.00, 3),
(5, 67, 'L', 0.00, 1),  
(6, 96, 'M', 10.00, 2),
(6, 66, 'XL', 10.00, 1),
(7, 7, 'S', 3.00, 1),
(8, 8, 'XXL', 0.00, 1),
(8, 57, 'L', 2.00, 1),
(8, 81, 'M', 10.00, 1),
(8, 28, 'S', 0.00, 1),
(9, 19, 'XL', 0.00, 1),
(9, 92, 'M', 0.00, 1),
(9, 48, 'XXL', 5.00, 1),
(10, 80, 'S', 0.00, 1),
(10, 100, 'XL', 0.00, 1),
(11, 101, 'M', 1.00, 1),
(11, 81, 'L', 10.00, 1),
(11, 53, 'XXL', 0.00, 1),
(12, 72, 'S', 20.00, 1),
(12, 92, 'XL', 0.00, 1),
(12, 29, 'M', 5.00, 1),
(12, 82, 'XXL', 0.00, 1),
(13, 89, 'L', 10.00, 1),
(13, 77, 'S', 0.00, 1),
(14, 44, 'XL', 20.00, 1),
(14, 84, 'M', 2.00, 1),
(14, 34, 'XXL', 0.00, 1),
(14, 14, 'L', 0.00, 1),
(15, 55, 'S', 30.00, 1),
(16, 46, 'XXL', 0.00, 1),
(16, 76, 'M', 6.00, 1),
(16, 96, 'XL', 10.00, 1),
(17, 17, 'L', 10.00, 1),
(17, 77, 'S', 0.00, 1),
(17, 37, 'XXL', 7.00, 1),
(17, 97, 'M', 0.00, 1),
(18, 100, 'XL', 0.00, 1),
(18, 104, 'L', 0.00, 1),
(19, 89, 'S', 10.00, 1),
(19, 19, 'XXL', 0.00, 1),
(19, 33, 'M', 6.00, 1),
(19, 53, 'XL', 0.00, 1),
(19, 74, 'L', 5.00, 1),
(20, 20, 'S', 5.00, 1),
(20, 23, 'XXL', 10.00, 1),
(20, 30, 'M', 0.00, 1),
(20, 20, 'XL', 5.00, 1),
(20, 102, 'L', 0.00, 2),
(20, 35, 'S', 3.00, 2),
(21, 78, 'XXL', 20.00, 3),
(21, 82, 'M', 0.00, 3),
(21, 100, 'XL', 0.00, 9),
(22, 11, 'S', 6.00, 2),
(22, 98, 'XXL', 0.00, 2),
(22, 71, 'M', 6.00, 3),
(23, 31, 'XXL', 7.00, 7),
(24, 105, 'XL', 0.00, 9),
(25, 88, 'S', 0.00, 2),
(26, 13, 'XXL', 10.00, 6),
(27, 22, 'M', 0.00, 7),
(27, 9, 'XXL', 10.00, 3),
(28, 34, 'L', 0.00, 2),
(28, 55, 'XL', 30.00, 9),
(29, 10, 'S', 10.00, 1),
(30, 3, 'XXL', 5.00, 1),
(31, 31, 'XL', 7.00, 2),
(31, 21, 'M', 8.00, 1),
(32, 81, 'XXL', 10.00, 6),
(32, 61, 'L', 9.00, 2),
(33, 33, 'S', 1.00, 4),
(33, 3, 'XL', 5.00, 2),
(33, 33, 'XXL', 1.00, 4),
(34, 71, 'M', 6.00, 4),
(34, 72, 'XXL', 20.00, 7),
(35, 11, 'S', 6.00, 2),
(35, 27, 'XL', 5.00, 1), 
(36, 12, 'M', 10.00, 4),
(36, 104, 'L', 13.00, 4),
(37, 17, 'XXL', 10.00, 2),
(37, 16, 'S', 27.00, 1),
(38, 33, 'XXL', 1.00, 7),
(38, 29, 'L', 10.00, 5),
(39, 31, 'XL', 7.00, 2),
(39, 11, 'XXL', 6.00, 4),
(40, 40, 'S', 0.00, 1),
(40, 44, 'XL', 20.00, 5);


INSERT INTO [Order] (CartID, AddressID, TotalPrice, OrderDate, OrderStatus)
SELECT CartID, AddressID, dbo.CalculateOrderTotalPrice(CartID), OrderDate, OrderStatus
FROM (VALUES
(1, 1, '2024-04-02', 'Processing'),
    (2, 2, '2024-04-02', 'Processing'),
    (3, 3, '2024-04-03', 'Shipped'),
    (4, 4, '2024-04-03', 'Delivered'),
    (5, 5, '2024-04-04', 'Cancelled'),
    (6, 6, '2024-04-04', 'Processing'),
    (7, 7, '2024-04-05', 'Processing'),
    (8, 8, '2024-04-05', 'Shipped'),
    (9, 9, '2024-04-06', 'Delivered'),
    (10, 10, '2024-04-06', 'Cancelled'),
    (11, 11, '2024-04-07', 'Processing'),
    (12, 12, '2024-04-07', 'Processing'),
    (13, 13, '2024-04-08', 'Shipped'),
    (14, 14, '2024-04-08', 'Processing'),
    (15, 15, '2024-04-09', 'Shipped'),
    (16, 16, '2024-04-09', 'Delivered'),
    (17, 17, '2024-04-10', 'Processing'),
    (18, 18, '2024-04-10', 'Cancelled'),
    (19, 19, '2024-04-11', 'Processing'),
    (20, 20, '2024-04-11', 'Processing'),
    (21, 21, '2024-04-12', 'Processing'),
    (22, 22, '2024-04-12', 'Processing'),
    (23, 23, '2024-04-13', 'Shipped'),
    (24, 24, '2024-04-13', 'Delivered'),
    (25, 25, '2024-04-14', 'Cancelled'),
    (26, 26, '2024-04-14', 'Processing'),
    (27, 27, '2024-04-15', 'Processing'),
    (28, 28, '2024-04-15', 'Shipped'),
    (29, 29, '2024-04-16', 'Delivered'),
    (30, 30, '2024-04-16', 'Cancelled'),
    (31, 31, '2024-04-17', 'Processing'),
    (32, 32, '2024-04-17', 'Processing'),
    (33, 33, '2024-04-18', 'Shipped'),
    (34, 34, '2024-04-18', 'Processing'),
    (35, 35, '2024-04-19', 'Shipped'),
    (36, 36, '2024-04-19', 'Delivered'),
    (37, 37, '2024-04-20', 'Processing'),
    (38, 38, '2024-04-20', 'Cancelled'),
    (39, 39, '2024-04-21', 'Processing'),
    (40, 40, '2024-04-21', 'Processing')
) AS OrderData(CartID, AddressID, OrderDate, OrderStatus);


--ADD Delivery Persons
INSERT INTO DeliveryPerson (DeliveryPersonFName, DeliveryPersonLName, PhoneNumber) VALUES 
('John', 'Smith', '+1234567890'),
('Jane', 'Doe', '+1234567891'),
('Emily', 'Jones', '+1234567892'),
('Michael', 'Brown', '+1234567893'),
('Chloe', 'Davis', '+1234567894'),
('James', 'Wilson', '+1234567895'),
('Patricia', 'Martinez', '+1234567896'),
('Robert', 'Garcia', '+1234567897'),
('Linda', 'Rodriguez', '+1234567898'),
('David', 'Hernandez', '+1234567899'),
('Elizabeth', 'Lopez', '+1234567800'),
('William', 'Gonzalez', '+1234567801'),
('Jennifer', 'Williams', '+1234567802'),
('Richard', 'Johnson', '+1234567803'),
('Jessica', 'Miller', '+1234567804'),
('Charles', 'Martinez', '+1234567805'),
('Sarah', 'Davis', '+1234567806'),
('Thomas', 'Garcia', '+1234567807'),
('Karen', 'Lopez', '+1234567808'),
('Christopher', 'Wilson', '+1234567809');


-- Insert Data according to Order table using Joins for consistency 
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, [Size], Price)
SELECT 
    o.OrderID,
    ci.ProductID,
    ci.Quantity,
    ci.[Size],
    ci.ItemPrice
FROM 
    [Order] o
INNER JOIN 
    Cart c ON o.CartID = c.CartID
INNER JOIN 
    CartItem ci ON c.CartID = ci.CartID


-- Invoice Insertion
INSERT INTO Invoice (OrderID,TotalAmount, InvoiceDate)
SELECT 
    o.OrderID,
    o.TotalPrice,
    o.OrderDate
FROM [Order] o


 --Payment Table Insertion
 INSERT INTO Payment (InvoiceNumber, Amount, PaymentDate, PaymentMethod, [Status])
SELECT 
    i.InvoiceNumber,
    i.TotalAmount,
    i.InvoiceDate,
    'Credit Card',
    CASE 
        WHEN o.OrderStatus = 'Processing' THEN 'Pending'
        WHEN o.OrderStatus = 'Shipped' THEN 'Success'
        WHEN o.OrderStatus = 'Delivered' THEN 'Success'
        WHEN o.OrderStatus = 'Cancelled' THEN 'Failed'
        ELSE 'Pending'
    END
FROM Invoice i
JOIN [Order] o ON i.OrderID = o.OrderID


-- Insert data into Delivery
INSERT INTO Delivery (InvoiceNumber, DeliveryPersonID, ExpectedDeliveryDate, ActualDeliveryDate, DeliveryStatus, DeliveryMode) 
SELECT 
    i.InvoiceNumber,
    (ABS(CHECKSUM(NEWID())) % 20) + 1 AS DeliveryPersonID, -- Since we have 20 Delivery person , random values 1 to 20
    DATEADD(day, 2, OrderDate) AS ExpectedDeliveryDate, --Expected delivery date is 2 days after the order date
    CASE 
        WHEN OrderStatus = 'Delivered' THEN DATEADD(day, 2, OrderDate) -- If delivered, set actual delivery date to expected date
        ELSE NULL -- Otherwise, it's NULL since it hasn't been delivered yet
    END AS ActualDeliveryDate,
    CASE 
        WHEN o.OrderStatus = 'Shipped' THEN 'In Transit'
        WHEN o.OrderStatus = 'Delivered' THEN 'Delivered'
        ELSE 'Pending'
    END AS DeliveryStatus,
    'Standard'
FROM Invoice i
JOIN [Order] o ON i.OrderID = o.OrderID
WHERE o.OrderStatus IN ('Shipped', 'Delivered');


-- Insert data into Shipping
INSERT INTO Shipping (InvoiceNumber, ShippingDate, ShippingStatus, TrackingNumber) 
SELECT 
    i.InvoiceNumber,
    o.OrderDate AS ShippingDate, -- Assume shipping date is the same as the order date for this example
    CASE 
        WHEN o.OrderStatus = 'Shipped' THEN 'In Transit'
        WHEN o.OrderStatus = 'Delivered' THEN 'Delivered'
        ELSE 'Pending'
    END AS ShippingStatus,
    'TRK' + CAST(i.InvoiceNumber AS VARCHAR(255))
FROM Invoice i
JOIN [Order] o ON i.OrderID = o.OrderID
WHERE OrderStatus IN ('Shipped', 'Delivered'); -- Only shipped or delivered orders



--Customer will add reviews for orders

INSERT INTO Review (CustomerID, OrderDetailsID, Rating, [Date])
SELECT 
    c.CustomerID,
    od.OrderDetailsID,
    ABS(CHECKSUM(NEWID()) % 5) + 1 AS Rating, -- Generates a random rating between 1 and 5
    DATEADD(day, 5, o.OrderDate) AS [Date] -- Review date is considered as 5 days after the order date
FROM 
    OrderDetails od
INNER JOIN 
    [Order] o ON od.OrderID = o.OrderID
INNER JOIN 
    Cart c ON o.CartID = c.CartID
WHERE 
    o.OrderStatus = 'Delivered' AND
    NOT EXISTS (SELECT 1 FROM Review r WHERE r.OrderDetailsID = od.OrderDetailsID); -- Avoid duplicating reviews for the same order detail
