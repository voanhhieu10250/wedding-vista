import * as esbuild from "esbuild";
import envFilePlugin from "esbuild-envfile-plugin";

// if the command arg has a watch flag, then we will watch the files
// and rebuild the project when a file changes
// otherwise, we will just build the project once
// and exit the process
const watch = process.argv.includes("--watch");

const configOptions = {
  logLevel: "info",
  entryPoints: ["app/javascript/*.*"],
  bundle: true,
  sourcemap: true,
  format: "esm",
  publicPath: "/assets",
  outdir: "app/assets/builds",
  minify: true,
  plugins: [envFilePlugin],
};

if (!watch) {
  console.log("🚀 Building project...");

  await esbuild.build(configOptions);
  console.log("✨ Build succeeded.");
} else {
  let ctx = await esbuild.context(configOptions);
  console.log("✨ Build succeeded.");

  await ctx.watch();
  console.log("watching...");
}
