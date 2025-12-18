const input = require("fs").readFileSync(
  require.resolve("./input.txt"),
  "utf-8"
);

/** @type {Array<[number, number]} */
const points = input
  .split("\n")
  .map((r) => r.split(",").map((v) => parseInt(v, 10)));

let largest = 0;
let largestInside = 0;
for (const [startX, startY] of points) {
  for (const [nextX, nextY] of points) {
    if (startX === nextX && startY === nextY) continue;

    const minX = Math.min(startX, nextX);
    const maxX = Math.max(startX, nextX);
    const minY = Math.min(startY, nextY);
    const maxY = Math.max(startY, nextY);

    const area = (maxX - minX + 1) * (maxY - minY + 1);
    if (area > largest) {
      largest = area;
    }

    if (area <= largestInside) continue;

    // center point check, ala https://en.wikipedia.org/wiki/Even%E2%80%93odd_rule
    const centerX = (minX + maxX) / 2;
    const centerY = (minY + maxY) / 2;
    let inside = false;
    for (const [i, [aX, aY]] of points.entries()) {
      const [bX, bY] = points[i - 1] ?? points[points.length - 1];
      if (centerX === aX && centerY === aY) {
        inside = true;
        break;
      }
      if (aY > centerY !== bY > centerY) {
        const slope = (centerX - aX) * (bY - aY) - (bX - aX) * (centerY - aY);
        if (slope === 0) {
          inside = true;
          break;
        }
        if (slope < 0 !== bY < aY) {
          inside = !inside;
        }
      }
    }

    if (!inside) continue;

    // check for edge intersections, ala https://en.wikipedia.org/wiki/Line%E2%80%93line_intersection
    let intersects = false;
    for (const [i, [aX, aY]] of points.entries()) {
      const [bX, bY] = points[i - 1] ?? points[points.length - 1];

      if (aX === bX) {
        if (aX > minX && aX < maxX) {
          const wallMinY = Math.min(aY, bY);
          const wallMaxY = Math.max(aY, bY);

          if (Math.max(minY, wallMinY) < Math.min(maxY, wallMaxY)) {
            intersects = true;
            break;
          }
        }
      } else if (aY === bY) {
        if (aY > minY && aY < maxY) {
          const wallMinX = Math.min(aX, bX);
          const wallMaxX = Math.max(aX, bX);

          if (Math.max(minX, wallMinX) < Math.min(maxX, wallMaxX)) {
            intersects = true;
            break;
          }
        }
      }
    }

    if (intersects) continue;

    if (area > largestInside) {
      largestInside = area;
    }
  }
}

console.log(`Part 1 Answer: ${largest}`);
console.log(`Part 2 Answer: ${largestInside}`);
