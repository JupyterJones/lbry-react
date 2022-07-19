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
    <link rel="stylesheet" href="../mystyle.css">
</head>

<body>
    <?php include '../menu.php'; ?>
    <?php include '../heading.php'; ?>

    <div class="wrapper>">
        <h1>Hints and tips on HTML and CSS</h1>
        <p>
            The correct HTML and css can truely bring a webpage to life. <span class="edu sz">Fonts have a fantastic effect on webpages appearance.</span> Some very slight enhancments such as a link's appearance changing when a mouse passes over creates a nice interactive effect. Font size, shadow and background can be created to respond to a mouse over.<span class="HOV"> For example try THIS sentence.</span>
        </p>
        <pre>
        <code>This is an example of what created the paragraph above.</code>
  The HTML:
The correct HTML and css can truely bring a webpage to life. &lt;span class="edu sz"&gt;Fonts have a fantastic effect on webpages appearance. &lt;/span&gt; Some very slight enhancments such as a link's appearance changing when a mouse passes over creates a nice interactive effect. Font size, shadow and background can be created to respond to a mouse over.&lt;span class ="HOV"&gt; For example try THIS sentence.&lt;/span&gt;
    
  The CSS:
@import url('https://fonts.googleapis.com/css2?family=Edu+TAS+Beginner&display=swap');  
.HOV:hover { background-color: rgb(159, 208, 228); }
.Quick{ font-family: 'Quicksand', sans-serif; }
.edu{ font-family: 'Edu TAS Beginner', cursive;}
.sz:hover{ font-size:1.5em; }
</pre>
    </div>
    <script src="" async defer></script>
</body>

</html>