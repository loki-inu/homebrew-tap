class Relnote < Formula
  desc "Turn a git range into GitHub release notes or a CHANGELOG.md section"
  homepage "https://loki-inu.github.io/relnote/"
  url "https://github.com/loki-inu/relnote/archive/refs/tags/v0.3.3.tar.gz"
  sha256 "a251c1da415864bf20bf5a6c94d1cb143651641a0ce32883d5add23c2927e925"
  license "MIT"
  head "https://github.com/loki-inu/relnote.git", branch: "main"

  depends_on "python@3.13"

  def install
    # relnote is pure standard-library Python: no third-party resources.
    libexec.install "relnote"
    (bin/"relnote").write <<~SH
      #!/bin/bash
      export PYTHONPATH="#{libexec}${PYTHONPATH:+:$PYTHONPATH}"
      exec "#{Formula["python@3.13"].opt_bin}/python3.13" -m relnote "$@"
    SH
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/relnote --version")

    system "git", "init", "-q", "-b", "main"
    system "git", "config", "user.name", "Test"
    system "git", "config", "user.email", "test@example.com"
    system "git", "commit", "-q", "--allow-empty", "-m", "chore: init"
    system "git", "tag", "v0.1.0"
    system "git", "commit", "-q", "--allow-empty", "-m", "feat(cli): add sync --dry-run"
    system "git", "commit", "-q", "--allow-empty", "-m", "fix: keep tags with commas"

    notes = shell_output("#{bin}/relnote")
    assert_match "### Features", notes
    assert_match "add sync --dry-run", notes
    assert_match "### Fixes", notes
    assert_equal "v0.2.0\n", shell_output("#{bin}/relnote --next-version")

    system bin/"relnote", "--changelog", "CHANGELOG.md", "--changelog-title", "v0.2.0",
           "--date", "2026-01-01", "--quiet"
    assert_match "## [v0.2.0] - 2026-01-01", (testpath/"CHANGELOG.md").read
  end
end
