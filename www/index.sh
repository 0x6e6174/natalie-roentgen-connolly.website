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
            <h1>natalie roentgen connolly</h1>
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
          <div>discord: 0x6e6174</div>
          <div>E-mail: natalie-roentgen-connolly at mail.natalie-roentgen-connolly.website</div>
          <div>git(hub): <a href="https://github.com/0x6e6174">0x6e6174</a></div>
          <div>git(.natalieee.net): <a href="https://git.natalieee.net/nat">nat</a></div>
          <div>less {serious,"professional"} website: <a href="https://natalieee.net">natalieee.net</a></div>
        </div>
      </section>
      <section id="skills">
        <h2>skills</h2>
        <ul>
          <li>several years of python experience</li>
          <li>vanilla javascript (& gjs)</li>
          <li>linux system administration</li>
          <li>git</li>
          <li>html/(s)css</li>
          <li>horrible bash scripts (like this website)</li>
          <li>nginx</li>
        </ul>
      </section>
      <section id="experience">
        <h2>experience</h2>
        <ul>
          <li>lead programmer of FTC 267 (2021-2023)</li>
          <ul>
            <li>responsible for programming the robot and coordinating with the build team</li>
          </ul>
          <li>team captain of FTC 187 (2023-2024)</li>
          <ul>
            <li>responsible for coordinating team members, delegating tasks, and other administrative duties</li>
          </ul>
          <li><a href="https://github.com/Aylur/astal/pull/288">wrote python bindings for libastal</a></li>
          <li>created <a href="https://git.natalieee.net/nat/natalie-roentgen-connolly.website">this website</a> and <a href="https://git.natalieee.net/nat/webbed-site">natalieee.net</a></li>
        </ul>
      </section>
      <section>
        <h2>education</h2>
        <ul>
          <li>3 years at benson polytechnic highschool (2021-2024)</li>
          <li>earned GED through PCC Yes to College program</li>
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
