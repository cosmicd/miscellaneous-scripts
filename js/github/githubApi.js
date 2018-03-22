const path = require("path");
const logger = require("./loggers-winston").localdev(
  "info",
  path.basename(__filename)
);
const { execSync } = require("child_process");

const GHRepo = async par => {
  const cmd =
    "curl -u " + par.username + par.cmdMethod + par.cmdPath + par.cmdData;
  logger.info("Executing command: %s", cmd);
  execSync(cmd, { shell: "/bin/bash", stdio: [0, 1, 2] });
};
const createRepo = async par => {
  const params = {
    username: par.Username,
    cmdMethod: "",
    cmdPath: " https://api.github.com/user/repos ",
    cmdData: " -d '" + JSON.stringify(par.Data) + "'"
  };
  await GHRepo(params);
  const repoURL =
    "https://github.com/" + par.Username + "/" + par.Data.name + ".git";
  const cmdInit =
    "cd " + par.LocalPath + " && git init ; git remote add origin " + repoURL;
  logger.info("Executing command: %s", cmdInit);
  execSync(cmdInit, { shell: "/bin/bash", stdio: [0, 1, 2] });
};

const deleteRepo = async par => {
  const params = {
    username: par.Username,
    cmdMethod: " -X DELETE ",
    cmdPath:
      " https://api.github.com/repos/" + par.Username + "/" + par.Data.name,
    cmdData: ""
  };
  await GHRepo(params);
};

const deployRepo = async par => {
  let reponame = par.Data.name;
  const repoURL =
    "https://github.com/" + par.Username + "/" + reponame + ".git";
  const cmd =
    "cd " +
    par.LocalPath +
    " && git init ; git add . ; git commit -m '" +
    par.CommitMessage +
    "'" +
    " ; git pull " +
    repoURL +
    " ; git push origin master";
  logger.info("Executing command: %s", cmd);
  execSync(cmd, { shell: "/bin/bash", stdio: [0, 1, 2] });
};

module.exports = {
  createRepo,
  deleteRepo,
  deployRepo
};
