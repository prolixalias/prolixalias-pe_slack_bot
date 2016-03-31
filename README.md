# skel
[![Build Status](https://travis-ci.org/ncorrare/ncorrare-pe_slack_bot.svg?branch=master)](https://travis-ci.org/ncorrare/ncorrare-pe_slack_bot)

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with skel](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with skel](#beginning-with-skel)

## Overview

This module configures the PE Bot for Slack.

## Setup

### Setup Requirements

Classify your Master with the pe_slack_bot.
You'll need at least to make your $slack_api_key available as a variable. You can get it by clicking the Add to Slack Button below (it will call back to a web page showing your API Key for the bot).

<a href="https://slack.com/oauth/authorize?scope=bot&client_id=22553403825.31013651447"><img alt="Add to Slack" height="40" width="139" src="https://platform.slack-edge.com/img/add_to_slack.png" srcset="https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x" /></a>
In order to do orchestration tasks, you'll need a token in /opt/puppetlabs/server/data/puppetserver/.puppetlabs/token. Gifs will be available soon to illustrate the project, or check the puppet-access documentation. 

### Beginning with pe_slack_bot

Check the documentation on how to use the bot, or try on of the following:
- puppet status $certname
- puppet job list <limit> <number>
- puppet job show $showid
- puppet app list
- puppet job run <environment> <app> <noop>

