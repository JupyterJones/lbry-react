#! /usr/bin/env python
import twitter, Tkinter

class TwitWindow :

    """ Display Twitter output in a TkInter window."""

    def __init__(self) :
        self.username = "JackLNorthrup"
        self.password = "tweetIT4me"
        self.num_entries = 11

    def CreateWindow(self) :
        # Lists to hold the labels and text areas
        self.labels = []
        self.texts = []

        # Create the main window
        self.tkroot = Tkinter.Tk()
        self.tkroot.title("Twit")

        # Create all the labels and text widgets:
        for i in range(0, self.num_entries) :
            self.labels.append(Tkinter.Label(self.tkroot))
            self.labels[i].config(bg="#07c", fg="white")
            self.labels[i].pack(expand=False, fill=Tkinter.X)

            self.texts.append(Tkinter.Text())
            self.texts[i].config(width=55, height=3)
            self.texts[i].config(bg="#eff", fg="black")
            self.texts[i].config(wrap=Tkinter.WORD)
            #self.texts[i].tag_config('link', foreground="blue")
            #self.texts[i].tag_bind('link', '<Shift-Button-1>', blockLink)

            #self.texts[i].tag_bind('link', '<Button-1>', showLink)
            #self.texts[i].tag_bind('link', '<Button-2>', showLink)
            #self.texts[i].tag_bind("link", "<Enter>", show_hand_cursor)
            #self.texts[i].tag_bind("link", "<Leave>", show_arrow_cursor)
            #self.texts[i].config(cursor="arrow")
            self.texts[i].pack(expand=True)

        self.api = twitter.Api(username=self.username, password=self.password)

        self.UpdateWindow()
        self.tkroot.mainloop()

    def UpdateWindow(self) :
        statuses = self.api.GetFriendsTimeline(self.username)
        for i in range(0, self.num_entries) :
            self.texts[i].delete(1.0, Tkinter.END)  # Clear the old text

            if i < len(statuses) :
                # Update the label with the user's name and screen name
                user = statuses[i].user
                labeltext = user.name + " (" + user.screen_name + ")"
                self.labels[i].config(text=labeltext)

                # Display the text of the tweet
                self.texts[i].insert(Tkinter.END, statuses[i].text)

        # Run this again five minutes from now:
        self.timer = self.tkroot.after(300000, self.UpdateWindow)

# main
win = TwitWindow()
win.CreateWindow()
