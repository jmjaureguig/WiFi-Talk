# WiFi-Talk

Basics in radio and directional finding using RPi, antennas and arduinos.

![Cantenna](images/wifi-DF-prototype.jpg)

## Disclaimer

**This information is for educational and informational purposes only. 
You have the final decision on modifing your hardware, software, and use of it.
And yours is the responsability of any consequences of the improper use of it.**

**This is only a prototype, intensionally limited in speed and efficiency to
aid in learning radio, any modifications for commercial or malicious intentions
implies you know what you are doing, the risks and consequences.**


# Summary
Everything started with a comment during a twitch live on
[zerialkiller](https://www.twitch.tv/zerialkillerhacking) channel, someone
suggested of ways to find WiFi devices and here I am a couple of months later.

The first part is how to keep your hardware safe, electronics after reaching
their limits, there is no `UNDO` button. And as described in the disclaimer,
this is a slow (but working) prototype with the sole objective of learning,
to serve as a minimal base to start. Check the video,
I'm sure you will find many ideas on how to continue.


# The parts

This play have three acts:
1. RF hardware connections and not frying electronics.
2. Simple arduino firmware that moves the antenna.
3. Slow and inefficient scripts capturing and plotting data.


## RF hardware

### Pringles can

This is a bad option, the diameter is off by several millimeters. In the other
and, it is easy to get one, easy to drill and install the monopole. Make a 6mm
hole from the back of the can to install the dipole later.


### 1/4 wave monopole

**SMA and RP-SMA connector**
There are two types of SMA connectors, SMA and RP-SMA, the RP for
reverse-polarity, RF-SMA was designed to comply with FCC regulations and
avoid what we are going to do, connect Wi-Fi equipment to radio equipment not
designed for that. Check the connector and buy the adapter you need.

The total length is ~31-mm including any extra length from the connector
itself. The first time I made one of these antennas I used calipers and
sand paper to be sure the length was right down to 0.1-mm now that I have
the equipment to see how close it needs to be, you can save time,
+/-1-mm is close enough.


### Unnecessary 3D printed parts

I make a clamp to hold the cantenna, hold the USB dongle on top and plug into
the stepper motor axis directly. I'm using a *28BYJ-48* motor, in case you use
the same check the [OpenSCAD](wifi-DF-mount.scad) just change `axis_d` and `axis_t` to make the
square hole match the axis of your motor.
