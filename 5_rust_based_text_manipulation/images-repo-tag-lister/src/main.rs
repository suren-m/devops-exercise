use images_repo_tag_lister::execute;
use structopt::StructOpt;

#[derive(StructOpt)]
struct Cli {
    #[structopt(default_value = "all")]
    repos: String,
}

fn main() {
    let args = Cli::from_args();
    let filter = args.repos;

    // See lib.rs
    let results = execute(&filter);

    for result in results {
        println!("{}", result);
    }
}
