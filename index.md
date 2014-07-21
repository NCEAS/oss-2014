---
layout: bootcamp
root: .
venue: NCEAD and RENCI
address: Santa Barbara, CA and Chapel Hill, NC
country: United-States
humandate: July 21-Aug 8, 2014
humantime: 8:15 am - 5:15 pm
startdate: 2014-07-21
enddate: 2014-08-09
latlng: 41.7901128,-87.6007318
registration: restricted
instructor: ["Matthew Jones", "Mark Schildhauer", "Karthik Ram"]
helper: []
contact: oss2014@nceas.ucsb.edu
---
<!--
    Edit the values in the parameter block above to be appropriate for your bootcamp.
    Please use three-letter month names for the 'humandate' field.
-->

<h2>General Information</h2>

<!-- This block displays the instructors' names if they are available. -->
{% if page.instructor %}
<p>
  <strong>Instructors:</strong>
  {{page.instructor | join: ', ' %}}
</p>
{% endif %}

<!-- This block displays the helpers' names if they are available. -->
{% if page.helper %}
<p>
  <strong>Helpers:</strong>
  {{page.helper | join: ', ' %}}
</p>
{% endif %}

<!--
    Modify this block to reflect the target audience for your bootcamp.
    In particular, if it is only open to people from a particular institution,
    or if specialized prerequisite knowledge is required, please mention that.
-->
<p>
  <strong>Who:</strong>
  The course is aimed at graduate students and other researchers.
</p>

<!--
    This block displays the address and links to a map showing directions.
-->
{% if page.latlng %}
<p>
  <strong>Where:</strong>
  {{ page.address }}.
  Get directions with
  <a href="//www.openstreetmap.org/?mlat={{ page.latlng | replace:',','&mlon=' }}&zoom=16">OpenStreetMap</a>
  or
  <a href="//maps.google.com/maps?q={{ page.latlng }}">Google Maps</a>.
</p>
{% endif %}

<!--
    Modify the block below if there are any special requirements.
-->
<p>
  <strong>Requirements:</strong>
  Participants must bring a laptop with a few specific software packages installed
  (listed below).
</p>

<!--
    This block automatically inserts a contact email address if one has been specified for the page.
-->
<p>
  <strong>Contact</strong>:
  Please mail
  {% if page.contact %}
    <a href='mailto:{{page.contact}}'>{{page.contact}}</a>
  {% else %}
    <a href='mailto:{{site.contact}}'>{{site.contact}}</a>
  {% endif %}
  for more information.
</p>

<hr/>

<!--
    Edit this block to show the agenda for your bootcamp.
-->
<h2>Lessons</h2>

<div class="row-fluid">
  <div class="span6">
    <h3>Day 1</h3>
    <ul>
        <li><a href="novice/shell/">Servers, Networks, and the Command Shell</a></li>
    </ul>
  </div>
  <div class="span6">
    <h3>Day 2</h3>
    <ul>
        <li><a href="novice/shell/">Servers, Networks, and the Command Shell</a></li>
    </ul>
  </div>
</div>

Done.
