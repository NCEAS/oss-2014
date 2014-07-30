@q01: #a50026;
@q02: #d73027;
@q03: #f46d43;
@q04: #fdae61;
@q05: #fee090;
@q06: #e0f3f8;
@q07: #abd9e9;
@q08: #74add1;
@q09: #4575b4;
@q10: #313695;

Map {
  background-color: #b8dee6;
}

#countries {
  ::outline {
    line-color: #85c5d3;
    line-width: 2;
    line-join: round;
  }
  polygon-fill: #fff;
}

#foodstampsncmerged {
  polygon-opacity:1;
  polygon-fill:#ae8;
  line-width: 0.5;
  line-color: #fff;
  
  
  ::textlayer [zoom>10] {
     text-name: [pct_povert] + '%';
     text-face-name: 'DejaVu Sans Bold';
     text-halo-radius: 1;
     text-fill: #000;
     text-halo-fill: #fff;
    text-allow-overlap: true;
  }
  
  [poverty_cl=1] { polygon-fill: @q01; }
  [poverty_cl=2] { polygon-fill: @q01; }
  [poverty_cl=3] { polygon-fill: @q02; }
  [poverty_cl=4] { polygon-fill: @q03; }
  [poverty_cl=5] { polygon-fill: @q04; }
  [poverty_cl=6] { polygon-fill: @q05; }
  [poverty_cl=7] { polygon-fill: @q06; }
  [poverty_cl=8] { polygon-fill: @q07; }
  [poverty_cl=9] { polygon-fill: @q08; }
  [poverty_cl=10] { polygon-fill: @q10; }
  
  [has_mkt=1] { line-color: #168; line-width:1.0; }
  [snap_mkt=1] { line-color: #000; }
  [wic_mkt=1] { line-color: #868; }
  [imp_mkt=1] { line-color: #168; line-width: 2.0; }
}


#farmersmktsnc {
  marker-width:6;
  marker-fill:#f45;
  marker-line-color:#813;
  marker-allow-overlap:true;
  marker-ignore-placement:true;
  
  [WIC='Y'] { marker-fill: #6f6; }
  [SNAP='Y'] { marker-fill: #ff6; }

  [zoom>10] { marker-width: 12; }  
}
