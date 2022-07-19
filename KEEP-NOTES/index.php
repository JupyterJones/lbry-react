<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]>      <html class="no-js"> <!--<![endif]-->
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title></title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="../mystyle.css">
</head>

<body>
    <?php include '../menu.php'; ?>
    <pre>
        #!/usr/bin/python3
        import sys
        import sqlite3
        conn = sqlite3.connect("notes.db")
        conn.text_factory = str
        c = conn.cursor()
        if len(sys.argv) < 3:
             print ("\n******* NOTE - Notes Editor **************")
             print ("Not enough options were passed.")     
             print ("NOTE requires 2 arguments. the first -H , -R , -I , -D or -S .\nThe second can be a period.")
             print ("If printing the database -T also add a filename of your choice ( no quotes required ):")
             print (" Example: NOTE -T Data2Text.txt")   
             print ("If wanting to read all entries use -R . (use the period)") 
             print ("even use the period with help.  -H .   must be entered.")
             print ("******************************************\n")
             sys.exit()
        mod = sys.argv[1]
        def create():
        
            import sqlite3
            conn = sqlite3.connect("notes.db")
            conn.text_factory = str
            c = conn.cursor()
            c.execute("CREATE VIRTUAL TABLE PROJECT using FTS4 (input)")
            conn.commit()
            text = "Database Created"
            return text
        
        def insert(data,conn=conn, c=c):
            c.execute("INSERT into PROJECT values (?)", (data,))
            for row in c.execute("SELECT ROWID,* FROM PROJECT ORDER BY ROWID DESC LIMIT 1"):
                print ("\nPOST VERIFIED:\n",row[0],row[1])
            conn.commit()
            conn.close()
            return data
        
        def search(data,conn=conn, c=c):
            #for row in c.execute("SELECT ROWID,* FROM PROJECT WHERE input MATCH ?",(data,)):
            #    print ("\nINFO Found Here:",row[0],row[1])
            for row in c.execute("SELECT ROWID,* FROM PROJECT"):
                if data in row[1]:    
                    print ("\nINFO Found Here:\n",row[0],row[1])
            #conn.commit()
            #conn.close()
        def delete(rowid,conn=conn, c=c):
            c.execute("DELETE FROM PROJECT WHERE rowid = ?", (rowid,))
            conn.commit()
            conn.close()
            text = "ROWID "+rowid+" Deleted"
            return text
        
        def main():
            conn = sqlite3.connect("notes.db")
            conn.text_factory = str
            c = conn.cursor()
            for row in c.execute("SELECT rowid, * FROM PROJECT"):
                print (row[0],": ",row[1])
        
        def prtmain(filename):
            fn = open(filename, "w")
            conn = sqlite3.connect("/home/jake/Desktop/notes.db")
            conn.text_factory = str
            c = conn.cursor()
            for row in c.execute("SELECT rowid, * FROM PROJECT"):
                TEXT = "id:"+str(row[0])+"\n"+str(row[1])
                TEXT = str(TEXT)
                TEXT = TEXT.replace('\\n','\n')
                TEXT = "".join(TEXT)
                fn.write(TEXT+'\n----\n')
        
        def HELP():
            TXT = """
            USE: NOTE argv[1] argv[2]
            argv[1] sets the mod:
            -I insert / -D delete / -R read / -H help
            examples:
            Notice the entry is in parenthese.
            -I  to insert "STUFF to be inserted"
            NOTE -I "STUFF to be inserted"
            -D to delete where rowid is 3
            NOTE -D 3
            Notice the period after -R . 
            -R . read all
            To search for the term "current project"
            NOTE -S 3
            -S "current project"
            NOTE -R .
            -H help on options
            NOTE -H .
            """
            print (TXT)
        
        if mod == "-H" or mod == "h":
            HELP()        
        if mod == "-R" or mod == "-r":
            main()
        if mod == "-I" or mod == "-i":
            data = sys.argv[2]
            insert(data)
        if mod == "-D" or mod == "-d":
            rowid = sys.argv[2]
            delete(rowid) 
        if mod == "-S" or mod == "-s":
            data = sys.argv[2]
            search(data)       
        if mod == "-T":
            filename = sys.argv[2]
            prtmain(filename)
        if mod == "-C" or mod == "-c":
            create()
            print (create)
        else:
            print ("_________________\n")
            print (sys.argv[2],"Command Completed")
    </pre>


    <script src="" async defer></script>
</body>

</html>