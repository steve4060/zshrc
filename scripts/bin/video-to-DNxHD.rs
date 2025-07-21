use std::process::Command;
use std::env;

fn convert_video(input_file: &str, output_file: &str) -> Result<(), String> {
    let status = Command::new("ffmpeg")
        .arg("-i")
        .arg(input_file)
        .arg("-c:v")
        .arg("dnxhd")
        .arg("-profile:v")
        .arg("dnxhr_hq")
        .arg("-pix_fmt")
        .arg("yuv422p")
        .arg("-c:a")
        .arg("pcm_s16le")
        .arg(output_file)
        .status()
        .map_err(|e| format!("Failed to execute ffmpeg: {}", e))?;

    if status.success() {
        Ok(())
    } else {
        Err(format!("ffmpeg exited with status: {}", status))
    }
}

fn main() {
    let args: Vec<String> = env::args().collect();
    if args.len() != 3 {
        eprintln!("Usage: {} INPUT_FILE OUTPUT_FILE", args[0]);
        std::process::exit(1);
    }

    let input_file = &args[1];
    let output_file = &args[2];

    match convert_video(input_file, output_file) {
        Ok(_) => println!("Video conversion successful!"),
        Err(e) => eprintln!("Error: {}", e),
    }
}

