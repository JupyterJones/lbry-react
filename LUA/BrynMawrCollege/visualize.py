# visualization of a single qubit state

import svgwrite
import math

from IPython.display import display, HTML, clear_output
from IPython.html.widgets import FloatSliderWidget, HTMLWidget, ContainerWidget, LatexWidget, CheckboxWidget

# state variables
a1, b1, rho1, theta1 = 1, 0, 1, 0
a2, b2, rho2, theta2 = 0, 0, 0, 0
last_sign_a1, last_sign_b1, last_sign_a2, last_sign_b2 = 1, 1, 1, 1

def spaces(n):
    return HTMLWidget(value=r"&nbsp;"*n)

def qubit_latex_expression():
    phase1 = "" if theta1 == 0 else "e^{%g i}" % round(theta1, 2)
    phase2 = "" if theta2 == 0 else "e^{%g i}" % round(theta2, 2)
    return "$\\vert\\psi\\rangle = %g %s \\vert 0 \\rangle + %g %s\\vert 1 \\rangle$" \
        % (round(rho1, 2), phase1, round(rho2, 2), phase2)

callbacksDisabled = False

# create sliders
a1_slider = FloatSliderWidget(min=-1, max=1, value=a1, description="a1", step=0.01)
b1_slider = FloatSliderWidget(min=-1, max=1, value=b1, description="b1", orientation="horizontal", step=0.01)
rho1_slider = FloatSliderWidget(min=0, max=1, value=rho1, description="magnitude1", step=0.01)
theta1_slider = FloatSliderWidget(min=0, max=round(2*math.pi, 2), value=theta1, description="phase1", step=0.01)

a2_slider = FloatSliderWidget(min=-1, max=1, value=a2, description="a2", step=0.01)
b2_slider = FloatSliderWidget(min=-1, max=1, value=b2, description="b2", step=0.01)
rho2_slider = FloatSliderWidget(min=0, max=1, value=rho2, description="magnitude2", step=0.01)
theta2_slider = FloatSliderWidget(min=0, max=round(2*math.pi, 2), value=theta2, description="phase2", step=0.01)

prob_slider = FloatSliderWidget(min=0, max=1, value=0, description="Probability of |1>", step=0.01)
latitude_slider = FloatSliderWidget(min=0, max=round(math.pi, 2), value=0, description="Bloch sphere latitude (theta)", step=0.01)
longitude_slider = FloatSliderWidget(min=0, max=round(2*math.pi, 2), value=0, description="Bloch sphere longitude (phi)", step=0.01)

c1_label = LatexWidget(value=r"$c_1 = a_1 + b_1 i = \rho_1 e^{i\theta_1}$")
c2_label = LatexWidget(value=r"$c_2 = a_2 + b_2 i = \rho_2 e^{i\theta_2}$")

qubit_label = LatexWidget(value=qubit_latex_expression())

c1_container = ContainerWidget(children=[c1_label, rho1_slider, theta1_slider, a1_slider, b1_slider])
c2_container = ContainerWidget(children=[c2_label, rho2_slider, theta2_slider, a2_slider, b2_slider])

top_container = ContainerWidget(children=[c1_container, spaces(20), c2_container])

image = HTMLWidget()
image_container = ContainerWidget(children=[spaces(60), image])

prob_container = ContainerWidget(children=[spaces(60), prob_slider])

latitude_container = ContainerWidget(children=[spaces(42), latitude_slider])
longitude_container = ContainerWidget(children=[spaces(42), longitude_slider])

bloch_container = ContainerWidget(children=[spaces(1), latitude_container, longitude_container])

qubit_container = ContainerWidget(children=[spaces(100), qubit_label])

phases_coupled = CheckboxWidget(value=False, description="Phases coupled")

all = ContainerWidget(children=[top_container, phases_coupled, qubit_container, image_container, prob_container, bloch_container])
display(all)

top_container.remove_class('vbox')
top_container.add_class('hbox')

qubit_container.remove_class('vbox')
qubit_container.add_class('hbox')

image_container.remove_class('vbox')
image_container.add_class('hbox')

prob_container.remove_class('vbox')
prob_container.add_class('hbox')

latitude_container.remove_class('vbox')
latitude_container.add_class('hbox')
longitude_container.remove_class('vbox')
longitude_container.add_class('hbox')


def theta(a, b):
    if a > 0 and b == 0:
        return 0
    elif a == 0 and b > 0:
        return math.pi/2
    elif a < 0 and b == 0:
        return math.pi
    elif a == 0 and b < 0:
        return 3*math.pi/2
    elif a > 0 and b > 0:
        return math.atan(float(b)/a)
    elif a < 0 and b > 0:
        return math.atan(float(b)/a) + math.pi
    elif a < 0 and b < 0:
        return math.atan(float(b)/a) + math.pi
    elif a > 0 and b < 0:
        return math.atan(float(b)/a) + 2*math.pi
    else:
        return None
    
def modulo2pi(theta):
    if theta < 0:
        theta += 2*math.pi
    elif theta >= 2*math.pi:
        theta -= 2*math.pi
    return theta

def rectangular(rho, theta):
    a = rho * math.cos(theta)
    b = rho * math.sin(theta)
    return a, b

def update_a1(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    a1 = min(max(new_trait_value, -rho1), rho1)
    b1 = math.sqrt(rho1**2 - a1**2) * last_sign_b1
    if rho1 > 0:
        theta1, previous = theta(a1, b1), theta1
        if phases_coupled.value == True:
            delta = theta1 - previous
            theta2 = modulo2pi(theta2 + delta)
            a2, b2 = rectangular(rho2, theta2)
    redraw()

def update_b1(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    b1 = min(max(new_trait_value, -rho1), rho1)
    a1 = math.sqrt(rho1**2 - b1**2) * last_sign_a1
    if rho1 > 0:
        theta1, previous = theta(a1, b1), theta1
        if phases_coupled.value == True:
            delta = theta1 - previous
            theta2 = modulo2pi(theta2 + delta)
            a2, b2 = rectangular(rho2, theta2)
    redraw()
    
def update_rho1(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    rho1 = new_trait_value
    a1, b1 = rectangular(rho1, theta1)
    rho2 = math.sqrt(1 - rho1**2)
    a2, b2 = rectangular(rho2, theta2)
    redraw()

def update_theta1(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    theta1, previous = new_trait_value, theta1
    a1, b1 = rectangular(rho1, theta1)
    if phases_coupled.value == True:
        delta = theta1 - previous
        theta2 = modulo2pi(theta2 + delta)
        a2, b2 = rectangular(rho2, theta2)
    redraw()

def update_a2(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    a2 = min(max(new_trait_value, -rho2), rho2)
    b2 = math.sqrt(rho2**2 - a2**2) * last_sign_b2
    if rho2 > 0:
        theta2, previous = theta(a2, b2), theta2
        if phases_coupled.value == True:
            delta = theta2 - previous
            theta1 = modulo2pi(theta1 + delta)
            a1, b1 = rectangular(rho1, theta1)
    redraw()

def update_b2(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    b2 = min(max(new_trait_value, -rho2), rho2)
    a2 = math.sqrt(rho2**2 - b2**2) * last_sign_a2
    if rho2 > 0:
        theta2, previous = theta(a2, b2), theta2
        if phases_coupled.value == True:
            delta = theta2 - previous
            theta1 = modulo2pi(theta1 + delta)
            a1, b1 = rectangular(rho1, theta1)
    redraw()
    
def update_rho2(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    rho2 = new_trait_value
    a2, b2 = rectangular(rho2, theta2)
    rho1 = math.sqrt(1 - rho2**2)
    a1, b1 = rectangular(rho1, theta1)
    redraw()

def update_theta2(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    theta2, previous = new_trait_value, theta2
    a2, b2 = rectangular(rho2, theta2)
    if phases_coupled.value == True:
        delta = theta2 - previous
        theta1 = modulo2pi(theta1 + delta)
        a1, b1 = rectangular(rho1, theta1)
    redraw()

def update_prob(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    rho2 = math.sqrt(new_trait_value)
    a2, b2 = rectangular(rho2, theta2)
    rho1 = math.sqrt(1 - rho2**2)
    a1, b1 = rectangular(rho1, theta1)
    redraw()

def update_latitude(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    latitude = new_trait_value
    rho1 = math.cos(latitude/2.0)
    rho2 = math.sin(latitude/2.0)
    a1, b1 = rectangular(rho1, theta1)
    a2, b2 = rectangular(rho2, theta2)
    redraw()

def update_longitude(trait_name, new_trait_value):
    if callbacksDisabled: return
    global a1, b1, rho1, theta1, a2, b2, rho2, theta2
    if phases_coupled.value == False:
        longitude = new_trait_value
        theta2 = modulo2pi(theta1 + longitude)
        a2, b2 = rectangular(rho2, theta2)
    redraw()


def redraw():
    global callbacksDisabled, last_sign_a1, last_sign_b1, last_sign_a2, last_sign_b2
    clear_output(wait=True)
    d = svgwrite.Drawing(size=(600, 300), debug=False)
    d.viewbox(-1.25, -1.25, 6, 2.5)    # xmin, ymin, width, height
    # c1
    d.add(d.circle(center=(0,0), r=1, fill='white', stroke='black', stroke_width=0.01))
    # arrow
    d.add(d.line(start=(0,0), end=(a1, -b1), stroke='blue', stroke_width=0.03))
    # arrowhead
    d.add(d.circle(center=(a1, -b1), r=0.03, fill='red'))
    # label
    d.add(d.text("c1", insert=(-0.1,-1.1), font_size=0.25))
    # projections
    d.add(d.line(start=(0,0), end=(a1, 0), stroke='red', stroke_width=0.01))
    d.add(d.line(start=(0,0), end=(0, -b1), stroke='red', stroke_width=0.01))

    # c2
    off = 3   # c2 offset
    d.add(d.circle(center=(0+off,0), r=1, fill='white', stroke='black', stroke_width=0.01))
    # arrow
    d.add(d.line(start=(0+off,0), end=(a2+off, -b2), stroke='blue', stroke_width=0.03))
    # arrowhead
    d.add(d.circle(center=(a2+off, -b2), r=0.03, fill='red'))
    # label
    d.add(d.text("c2", insert=(-0.1+off,-1.1), font_size=0.25))
    d.add(d.line(start=(0+off,0), end=(a2+off, 0), stroke='red', stroke_width=0.01))
    d.add(d.line(start=(0+off,0), end=(0+off, -b2), stroke='red', stroke_width=0.01))

    # update signs if non-zero
    last_sign_a1 = +1 if a1 > 0 else -1 if a1 < 0 else last_sign_a1
    last_sign_b1 = +1 if b1 > 0 else -1 if b1 < 0 else last_sign_b1
    last_sign_a2 = +1 if a2 > 0 else -1 if a2 < 0 else last_sign_a2
    last_sign_b2 = +1 if b2 > 0 else -1 if b2 < 0 else last_sign_b2

    # update qubit expression
    qubit_label.value = qubit_latex_expression()

    # update sliders
    callbacksDisabled = True
    a1_slider.value = round(a1, 2)
    b1_slider.value = round(b1, 2)
    rho1_slider.value = round(rho1, 2)
    theta1_slider.value = round(theta1, 2)
    a2_slider.value = round(a2, 2)
    b2_slider.value = round(b2, 2)
    rho2_slider.value = round(rho2, 2)
    theta2_slider.value = round(theta2, 2)
    prob_slider.value = round(rho2*rho2, 2)
    latitude_slider.value = round(2*math.acos(rho1), 2)
    longitude_slider.value = round(modulo2pi(theta2-theta1), 2)
    callbacksDisabled = False

    image.value = d.tostring()
    

a1_slider.on_trait_change(update_a1, 'value')
b1_slider.on_trait_change(update_b1, 'value')
rho1_slider.on_trait_change(update_rho1, 'value')
theta1_slider.on_trait_change(update_theta1, 'value')
a2_slider.on_trait_change(update_a2, 'value')
b2_slider.on_trait_change(update_b2, 'value')
rho2_slider.on_trait_change(update_rho2, 'value')
theta2_slider.on_trait_change(update_theta2, 'value')
prob_slider.on_trait_change(update_prob, 'value')
latitude_slider.on_trait_change(update_latitude, 'value')
longitude_slider.on_trait_change(update_longitude, 'value')
redraw()
    
