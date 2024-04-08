-----------------------------------------Encryption of the Password Column of Customer Table---------------------------------------------------------------------------------------
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'DataManagement@6201';

CREATE CERTIFICATE passwordEncryptCertificate WITH SUBJECT = 'Customer Password Encryption';

CREATE SYMMETRIC KEY passwordEncryptionKey WITH ALGORITHM = AES_256

ENCRYPTION BY CERTIFICATE passwordEncryptCertificate;

-- Encrypt the Password columns

OPEN SYMMETRIC KEY passwordEncryptionKey
DECRYPTION BY CERTIFICATE passwordEncryptCertificate;
UPDATE Customer
SET [Password] = EncryptByKey(Key_GUID('passwordEncryptionKey'), [Password]);
CLOSE SYMMETRIC KEY passwordEncryptionKey;


-- Decrypt and View the Password data
OPEN SYMMETRIC KEY passwordEncryptionKey
DECRYPTION BY CERTIFICATE passwordEncryptCertificate;
SELECT 
    [Password], 
    CONVERT(VARCHAR, DecryptByKey([Password])) AS DecryptedPassword
FROM 
    Customer;
CLOSE SYMMETRIC KEY passwordEncryptionKey;
