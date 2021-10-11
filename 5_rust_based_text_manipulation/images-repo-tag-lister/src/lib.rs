use std::process::Command;

pub fn execute(filter: &str) -> Vec<String> {
    let docker_images = get_docker_images();
    get_results(filter, &docker_images)
}

fn get_docker_images() -> String {
    let mut cmd = Command::new("sh");
    cmd.arg("-c").arg("docker images");
    let docker_images = cmd.output().expect("failed to execute process");

    String::from_utf8_lossy(&docker_images.stdout).to_string()
}

fn get_results(filter: &str, docker_images: &str) -> Vec<String> {
    let mut results = Vec::new();
    for line in docker_images.lines().skip(1) {
        if filter == "all" {
            parse_line(line, &mut results);
        } else {
            for repo in filter.to_lowercase().split(",") {
                if line.to_lowercase().contains(&repo) {
                    parse_line(line, &mut results);
                }
            }
        };
    }
    results
}

fn parse_line(line: &str, results: &mut Vec<String>) {
    let v: Vec<_> = line.split_whitespace().take(2).collect();
    let res = v.join(":");
    results.push(res);
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn filter_by_images() {
        let docker_images =
            "REPOSITORY              TAG                  IMAGE ID       CREATED         SIZE
            litecoin                1.0                  ef31e5c15bb5   5 hours ago     156MB
            litecoin                1.0-latest           ef31e5c15bb5   5 hours ago     156MB
            test                    1.1                  aaab3744652f   5 days ago      168MB
            nginx                   latest               f8f4ffc8092c   13 days ago     133MB";
        let filter = "litecoin,nginx";

        assert_eq!(
            vec!["litecoin:1.0", "litecoin:1.0-latest", "nginx:latest"],
            get_results(filter, docker_images)
        );
    }

    #[test]
    fn get_all() {
        let docker_images =
            "REPOSITORY              TAG                  IMAGE ID       CREATED         SIZE
            litecoin                1.0                  ef31e5c15bb5   5 hours ago     156MB
            litecoin                1.0-latest           ef31e5c15bb5   5 hours ago     156MB
            test                    1.1                  aaab3744652f   5 days ago      168MB
            nginx                   latest               f8f4ffc8092c   13 days ago     133MB";
        let filter = "all";

        assert_eq!(
            vec![
                "litecoin:1.0",
                "litecoin:1.0-latest",
                "test:1.1",
                "nginx:latest"
            ],
            get_results(filter, docker_images)
        );
    }
}
