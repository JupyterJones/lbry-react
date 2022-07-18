<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
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
<?php include 'menu.php'; ?>
<?php include 'heading.php'; ?>
    

    <h2>Create a temp file to hold commands</h2>

    <pre>

mktemp --help
Usage: mktemp [OPTION]... [TEMPLATE]
Create a temporary file or directory, safely, and print its name.
TEMPLATE must contain at least 3 consecutive 'X's in last component.
If TEMPLATE is not specified, use tmp.XXXXXXXXXX, and --tmpdir is implied.
Files are created u+rw, and directories u+rwx, minus umask restrictions.

  -d, --directory     create a directory, not a file
  -u, --dry-run       do not create anything; merely print a name (unsafe)
  -q, --quiet         suppress diagnostics about file/dir-creation failure
      --suffix=SUFF   append SUFF to TEMPLATE; SUFF must not contain a slash.
                        This option is implied if TEMPLATE does not end in X
  -p DIR, --tmpdir[=DIR]  interpret TEMPLATE relative to DIR; if DIR is not
                        specified, use $TMPDIR if set, else /tmp.  With
                        this option, TEMPLATE must not be an absolute name;
                        unlike with -t, TEMPLATE may contain slashes, but
                        mktemp creates only the final component
  -t                  interpret TEMPLATE as a single file name component,
                        relative to a directory: $TMPDIR, if set; else the
                        directory specified via -p; else /tmp [deprecated]
      --help     display this help and exit
      --version  output version information and exit

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Full documentation at: <https://www.gnu.org/software/coreutils/mktemp>
or available locally via: info '(coreutils) mktemp invocation'

</pre>
    <h3>Putting a tempfile to use</h3>
    <p>
        This is an example of using a tempfile to hold a series of terminal commands.
    </p>
    <pre>

$  dotnet
$  dotnet --list-sdks
$  tmppath=$(mktemp)
$  dotnet --list-sdks &gt;&gt; &quot;${tmppath}&quot;
$  dotnet --info &gt;&gt; &quot;${tmppath}&quot;
$  dotnet --list-runtimes &gt;&gt; &quot;${tmppath}&quot;
$  message=$(cat &quot;${tmppath}&quot;)
$  echo &quot;$message&quot;
$  FSHARP -i &quot;$message&quot;
$  FSHARP -r .
$  history 15
$  echo &quot;$message&quot;
$  tempinfo = $(tempinfo)
$  tempinfo=$(tempinfo)
$  history 15 &gt;&gt;&quot;${tmppath}&quot;

(base) <strong>jack@jack-Desktop</strong><strong>~/sharp/fsharp</strong>$ NOTE -i &quot;$message&quot;

</pre>

    <h2>read</h2>
    <p style="color:red;font-size:25px;">You can read into an array with read -a:</p>
    <pre>
$ read -a arr -p "Enter words: "
Enter words: v1 v2 v3 v4 v5
$ echo "${arr[@]}"
v1 v2 v3 v4 v5
$ read -a arr -p "Enter words: "
Enter words: v1 v2 v3 v4 v5 v6 v7 v8 v9 v10
$ echo "${arr[@]}"
v1 v2 v3 v4 v5 v6 v7 v8 v9 v10
</pre>

    <h2>mapfile</h2>
    <pre>

(base) jack@jack-Desktop:~/Desktop$ mapfile --help
mapfile: mapfile [-d delim] [-n count] [-O origin] [-s count] [-t] [-u fd] [-C callback] [-c quantum] [array]
    Read lines from the standard input into an indexed array variable.
    
    Read lines from the standard input into the indexed array variable ARRAY, or
    from file descriptor FD if the -u option is supplied.  The variable MAPFILE
    is the default ARRAY.
    
    Options:
      -d delim  Use DELIM to terminate lines, instead of newline
      -n count  Copy at most COUNT lines.  If COUNT is 0, all lines are copied
      -O origin Begin assigning to ARRAY at index ORIGIN.  The default index is 0
      -s count  Discard the first COUNT lines read
      -t    Remove a trailing DELIM from each line read (default newline)
      -u fd Read lines from file descriptor FD instead of the standard input
      -C callback   Evaluate CALLBACK each time QUANTUM lines are read
      -c quantum    Specify the number of lines read between each call to
                CALLBACK
    
    Arguments:
      ARRAY Array variable name to use for file data
    
    If -C is supplied without -c, the default quantum is 5000.  When
    CALLBACK is evaluated, it is supplied the index of the next array
    element to be assigned and the line to be assigned to that element
    as additional arguments.
    
    If not supplied with an explicit origin, mapfile will clear ARRAY before
    assigning to it.
    
    Exit Status:
    Returns success unless an invalid option is given or ARRAY is readonly or
    not an indexed array.


</pre>

    <h2>past</h2>
    <pre>
(base) jack@jack-Desktop:~/Desktop$ paste --help
Usage: paste [OPTION]... [FILE]...
Write lines consisting of the sequentially corresponding lines from
each FILE, separated by TABs, to standard output.

With no FILE, or when FILE is -, read standard input.

Mandatory arguments to long options are mandatory for short options too.
  -d, --delimiters=LIST   reuse characters from LIST instead of TABs
  -s, --serial            paste one file at a time instead of in parallel
  -z, --zero-terminated    line delimiter is NUL, not newline
      --help     display this help and exit
      --version  output version information and exit

GNU coreutils online help: <https://www.gnu.org/software/coreutils/>
Full documentation at: <https://www.gnu.org/software/coreutils/paste>
or available locally via: info '(coreutils) paste invocation'

    </pre>




    <h2>How To Customize Bash Prompt in Linux</h2>

    <h2></h2>Introduction
</body>
<p>
    In Linux, much of your work occurs from a command prompt, also known as the shell, or BASH (Bourne-Again Shell). The
    shell interprets your commands and passes them to the operating system for execution.

    This tutorial will show you how to customize or change your Linux BASH prompt.
    tutorial on customizing the Linux Bash Prompt
</p>
<pre>
username@hostname:~$

The first part of the prompt tells you the user that’s currently logged in. The second part identifies the hostname of the system.
The tilde sign ~ indicates that the current working directory is the current user’s home directory.
The dollar sign $ means the current user is a standard user.
A root user would be identified with a hash sign #.
</pre>
<h2>Customize Bash Prompt In Linux</h2>

<p>BASH reads a configuration file to determine its behavior. This file is in the home directory:<br />
    <code>~/.bashrc</code>
<p>Before you make any changes, create a backup copy of your configuration file. Open a terminal window, and enter the
    following:
</p><br />
<code>cp ~/.bashrc ~/.bashrc.bak</code>
<pre>
Note: The system uses the .bak file extension to indicate a backup.
Change Bash Prompt in Linux Permanently

Open the BASH configuration file for editing:
</pre>
<code>sudo nano ~/.bashrc</code>



<pre>
In this file, you should see several different settings. Some of them are descriptive lines in blue, uncommented with a # sign. Some are white, which indicates that they are enabled.

Scroll to the bottom of the configuration file. Add the following line:

PS1="MyCustomPrompt> "

Edit bashrc file to change BASH appearance.

You can replace MyCustomPrompt> with any string of text you like.

Save the file (ctrl-o > Enter) and exit (ctrl-x).

Refresh the BASH service to apply your changes. Enter the following:

source ~/.bashrc

Your command-line prompt should change to the following:

MyCustomPrompt>

The appearance of BASH prompt after changing bashrc configuration file.

Note: Learn everything you need to know about working with Bash comments.
Create a Temporary Change to the BASH Prompt

You can change the BASH prompt temporarily by using the export command. This command changes the prompt until the user logs out.

Set the BASH prompt to only display the username by entering the following:

export PS1="\u >"

The prompt should immediately change to look like this:

username >

The command to show only your username in the bash prompt.

You can reset the prompt by logging out, then logging back in.
Popular Custom Options for BASH Prompts

You can use these options in either method – temporarily with the export command, or permanently by editing the ~/.bashrc file.
Display Username and Domain Name

Use the –H option to display a a full hostname:

export PS1="\u\H "

You should see the hostname in the prompt.
Show full hostname in Linux BASH
Add Special Characters

You can add special characters to the prompt by placing them in order around the special options:

export PS1="\u@\H :"

This should display the following:

username@domain:

Note: We recommend ending the prompt with a special character or space. You should also place a space, colon, or angle-bracket just before the final quote mark. This method helps users tell the difference between the prompt and the command they’re typing.
Display Username Plus Shell Name and Version

Enter the following to show username, shell name, and version:

export PS1="\u >\s\v "

The prompt should change to the following:

username >bash4.4

Show username and bash version in the terminal
Add Date and Time to The BASH Prompt

Use the following options to display different formats for date and time:

d – Displays today’s date in [weekday]/[month]/[day]

export PS1="\u@\H>\d "

t – Displays the current time in 24-hour notation

export PS1="\u@\H>\t "

T – Displays the current time in 12-hour notation

export PS1="\u@\H>\T "

A – Displays the current time in 24-hour notation, with just hours and minutes

export PS1="\u@\H>\A "

Note: The \u@\H options preceding the date and time option add the username and full domain name.
Hide All Information in the BASH Prompt

Use this to prevent usernames or hostnames from displaying at the prompt:

export PS1="\W > "

You should see the following:

~ >

Differentiate Root User From Normal User

The normal BASH prompt displays a $ sign for a normal user. If you log in as a root user, a # sign is displayed. Use the $ code to indicate that the current user is not a root user:

export PS1="\u@\H \W:\$ "

More BASH Prompt Options

Here is a list of most of the options you can use for the BASH prompt.

Some of these commands may not work on all versions of Linux.

\a – A bell character
\d – Date (day/month/date)
\D{format} – Use this to call the system to respond with the current time
\e – Escape character
\h – Hostname (short)
\H – Full hostname (domain name)
\j – Number of jobs being managed by the shell
\l – The basename of the shells terminal device
\n – New line
\r – Carriage return
\s – The name of the shell
\t – Time (hour:minute:second)
\@ – Time, 12-hour AM/PM
\A – Time, 24-hour, without seconds
\u – Current username
\v – BASH version
\V – Extra information about the BASH version
\w – Current working directory ($HOME is represented by ~)
\W – The basename of the working directory ($HOME is represented by ~)
\! – Lists this command’s number in the history
\# – This command’s command number
\$ – Specifies whether the user is root (#) or otherwise ($)
\\– Backslash
\[ – Start a sequence of non-displayed characters (useful if you want to add a command or instruction set to the prompt)
\] – Close or end a sequence of non-displayed characters

How to Change BASH Prompt Color

You can change the text color of your BASH prompt. For example, to temporarily change the text of your BASH prompt to green, enter the following:

export PS1="\e[0;32m[\u@\h \W]\$ \e[0m"

Change the bash color in Linux

Your prompt should have the same text as normal but be colored green.

Here’s a breakdown of the commands:

• \e[ – Begin color changes
• 0;32m – Specify the color code
• [\u@\h \W]\$ – This is the code for your normal BASH prompt (username@hostname Workingdirectory $)
• \e[0m – Exit color-change mode

The first number in the color code specifies the typeface:

• 0 – Normal
• 1 – Bold (bright)
• 2 – Dim
• 4 – Underlined

The second number indicates the color you want:

• 30 – Black
• 31 – Red
• 32 – Green
• 33 – Brown
• 34 – Blue
• 35 – Purple
• 36 – Cyan
• 37 – Light gray

Additionally, if you combine the bright option with a color code, you get a lighter version of that color. For example, if you use color code 1;32, you would get light green instead of the normal green. If you use 1;33, you get yellow instead of brown.
How to Reset BASH Changes to Default Settings

There are two ways to reset the changes. For temporary changes (using the export PS1="" command), you can reset the default by logging out.

If you edited the \.bashrc file to make permanent changes, there are two methods to revert to default settings:

Render your changes as comments by editing the file and adding a # before each change you made.
Restore default settings from your backup by entering:

sudo cp ~/.bashrc.bak ~/.bashrc

Understanding Different Parts of BASH Prompt

Before you continue, reset your BASH prompt to the default. If you used the export command, log out and log back in. If you edited your ~/.bashrc file, place a # sign before each edit you made and save the file.

The BASH prompt contains four different values: PS1, PS2, PS3, and PS4.

The PS stands for Prompt Statement. So far, we’ve been working with the PS1 value. To see the current PS1 value, enter the following:

echo $PS1

Depending on the system, the terminal returns something like this for the default settings:
The output of the echo $PS1 command in the terminal


You might recognize the \u@\h options as the username and host. The w option displays the current working directory.

Now, display the PS2 value:

echo $PS2

The system should display just an angle-bracket:

>

Repeating the same command for PS3 should be blank.

For PS4, you’ll see a + sign.

Here are the different meanings for the different parts of the BASH prompt:

PS1 – This is the primary prompt display. This is where you set special characters or important information.
PS2 – This is the secondary prompt string. This is usually set as a divider between the prompt display and the text entry. It is also used to display when a long command is broken into sections with the \ sign.
PS3 – This is the prompt for the select command.
PS4 – This is the prompt for running a shell script in debug mode.
</pre>


<script src="" async defer></script>
</body>

</html>