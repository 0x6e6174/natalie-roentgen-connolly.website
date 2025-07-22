#!/bin/bash
# vim: ft=html

cat << EOF
<!DOCTYPE html>
<html>
  <head>
    <title>NRC website</title>
    <meta charset="UTF-8" />
    <script src="/perlin.js"></script>
    <link rel="stylesheet" href="/style.css">
    <meta property="og:image:url" content="https://natalie-roentgen-connolly.website/pfp.png"/>
    <meta property="og:image:width" content="200"/>
    <meta property="og:image:height" content="200"/>
    <meta property="og:image:alt" content="a wireframe diagram of a siemens s700 on a white background"/>
    <meta property="og:title" content="natalie roentgen connolly dot website">
    <meta property="og:description" content="one of the websites of natalie roentgen connolly. this one is more than the standard amount of 'professional.'">
    <meta property="og:url" content="https://natalie-roentgen-connolly.website">
  </head>
  <body>
    <canvas id='bg' width=400 height=400> </canvas>
    <main>
      <section id="card">
        <div class="header">
          <img src="/pfp.png" alt="the profile photograph natalie uses, a wireframe drawing of a siemens s700" width="200">
          <div class="header-text">
            <h1>Natalie Roentgen Connolly</h1>
            <div style="font-size: 1rem">.website</div>
            <div class="properties">
              <div>@0x6e6174</div><div class="spacer">|</div>
              <div>it/she</div><div class="spacer">|</div>
              <div>Portland, OR</div><div class="spacer">|</div>
              <div>$(($(($(date +%s) - $(date -d '2007-04-01' +%s))) / $((365*24*3600))))</div>
            </div>
            <hr>
            <div role="paragraph">
              A weird computer witch interested in system administration, computer engineering, open source, and software development.
            </div>
          </div>
        </div>
        <br>
        <div role="paragraph">this website is vaguely intendended to function as a {portfolio,prettier presentation of the information on my resume}.</div>
        <br>
        <h3>natalie elsewhere</h3>
        <div id="contact">
          <div>E-mail: natalie at natalieee.net</div>
          <div>git(hub.com): <a href="https://github.com/0x6e6174">0x6e6174</a></div>
          <div>git(.natalieee.net): <a href="https://git.natalieee.net/nat">nat</a></div>
          <div>Less {serious,"professional"} website (& blog): <a href="https://natalieee.net">natalieee.net</a></div>
        </div>
      </section>
      <section id="skills">
        <h2>skills</h2>
        <ul>
          <li>Several years of python experience</li>
          <li>Vanilla javascript (& gjs)</li>
          <li>linux system administration</li>
          <li>Git</li>
          <li>HTML/(S)CSS</li>
          <li>POSIX sh/bash scripting</li>
          <li>Nginx</li>
          <li>DNS</li>
        </ul>
      </section>
      <section id="experience">
        <h2>Experience</h2>
        <ul>
          <li>Lead programmer of FTC 267 (2021-2023)</li>
          <ul>
            <li>Responsible for programming the robot and coordinating with the build team</li>
          </ul>
          <li>Team captain of FTC 187 (2023-2024)</li>
          <ul>
            <li>Responsible for coordinating team members, delegating tasks, and other administrative duties. Additionally, I continued working as a programmer during this time.</li>
          </ul>
          <li>Wrote <a href="https://github.com/Aylur/astal/pull/288">python bindings</a> for <a href="https://github.com/Aylur/astal/">libastal</a>*</li>
          <li>Created this website and <a href="https://natalieee.net">natalieee.net</a></li>
          <li>Hosted various services for myself and friends, including:
            <ul>
              <li>Authoritative DNS</li>
              <li>File hosting</li>
              <li>A Git forge</li>
            </ul>
          </li>
        </ul>
        <footnote>
           *this pull request has since been made in to a seperate repository for compliance with the direction that the libastal project is taking
        </footnote>
      </section>
      <section>
        <h2>Education</h2>
        <ul>
          <li>3 years at benson polytechnic highschool (2021-2024)</li>
          <li>Earned a GED through PCC's Yes to College program</li>
          <li>Currently enrolled at PCC earning an associate's in electronic engineering technology.</li>
        </ul>
      </section>
    </main>
    <script>
      const start = Date.now();

      const canvas = document.getElementById('bg')
      const ctx = canvas.getContext("2d");
      const image = ctx.createImageData(canvas.width, canvas.height)
      const image_data = image.data;

      noise.seed(0x6e6174);

      function render() {
        const now = Date.now();
        const z = now * 0.0001;

        for (let x = 0; x < canvas.width; x++) {
          for (let y = 0; y < canvas.height; y++) {
            let value = Math.abs(noise.perlin3(x / 100, y / 100, z));
            value *= 128;

            const valueMod = value % 2;

            const fg = { r: 0x33, g: 0xb1, b: 0xff };
            const bg = { r: 0x10, g: 0x10, b: 0x10 };

            let factor = Math.min(Math.max((valueMod - 128) / 8 + value-8, (value*4 % 256)/64), 1);

            let r = Math.round(fg.r + (bg.r - fg.r) * factor);
            let g = Math.round(fg.g + (bg.g - fg.g) * factor);
            let b = Math.round(fg.b + (bg.b - fg.b) * factor);

            const pixel = (x + y * canvas.width) * 4;
            image_data[pixel]     = r;
            image_data[pixel + 1] = g;
            image_data[pixel + 2] = b;
            image_data[pixel + 3] = 255;
          }
        }

        ctx.putImageData(image, 0, 0);
      }

      function update() {
        requestAnimationFrame(update);
        render();
      }

      update()
    </script>
  </body>
</html>
EOF
