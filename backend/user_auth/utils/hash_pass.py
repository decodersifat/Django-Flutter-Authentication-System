import bcrypt

def hashPassword(pwd):

    pwd_bytes = pwd.encode('utf-8')
    salt = bcrypt.gensalt()  
    hashedPass = bcrypt.hashpw(pwd_bytes, salt)
    return hashedPass.decode('utf-8')

def pwdValidator(pwd, hashedPwd):
    pwd_bytes = pwd.encode('utf-8')
    hashedPwd_bytes = hashedPwd.encode('utf-8')
    if bcrypt.checkpw(password=pwd_bytes, hashed_password=hashedPwd_bytes):
        return True
    else:
        return False