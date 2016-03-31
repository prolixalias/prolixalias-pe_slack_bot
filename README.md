# skel
[![Build Status](https://travis-ci.org/ncorrare/ncorrare-pe_slack_bot.svg?branch=master)](https://travis-ci.org/ncorrare/ncorrare-pe_slack_bot)

#### Table of Contents

1. [Overview](#overview)
2. [Setup - The basics of getting started with skel](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with skel](#beginning-with-pe_slack_bot)
    * [What pe_slack_bot affects](#what-pe_slack_bot-affects)
3. [Limitations - OS compatibility, etc.](#limitations)
4. [Development - Guide for contributing to the module](#development)

## Overview

This module configures the PE Bot for Slack.

## Setup

### Setup Requirements

Classify your Master with the pe_slack_bot.
You'll need at least to make your $slack_api_key available as a variable. You can get it by clicking the Add to Slack Button below (it will call back to a web page showing your API Key for the bot).

<a href="https://slack.com/oauth/authorize?scope=bot&client_id=22553403825.31013651447&state=JWOWndvoFQJk"><img alt="Add to Slack" height="40" width="139" src="https://platform.slack-edge.com/img/add_to_slack.png" srcset="https://platform.slack-edge.com/img/add_to_slack.png 1x, https://platform.slack-edge.com/img/add_to_slack@2x.png 2x" /></a>

In order to do orchestration tasks, you'll need to configure the right permissions in "Access Control", in the PE Console, and a token in /opt/puppetlabs/server/data/puppetserver/.puppetlabs/token.

The following animations briefly illustrate how to do it, but for more information please refer to the Puppet Enteprise documentation

<img alt="RBAC" src="http://g.recordit.co/XLvXwjTRLs.gif"/>
<img alt="puppet-access" src="http://g.recordit.co/X83lQBYUpr.gif"/>


### Beginning with pe_slack_bot

Check the documentation on how to use the bot, or try on of the following:
- puppet status $certname
- puppet job list <limit> <number>
- puppet job show $showid
- puppet app list
- puppet job run <environment> <app> <noop>

<img alt="puppet status node screenshot" src="http://g.recordit.co/D0soiMMLFQ.gif">

### What pe_slack_bot affects
The bot is designed to run with the Puppet Enterprise Ruby (in order not to affect neither Puppet nor the system ruby). It does however install a number of gems:
- puma
- sinatra
- dotenv
- slack-ruby-bot
- puppetdb-ruby

It also creates a configuration file in the Puppet configuration directory (/etc/puppetlabs/puppet by default), and a systemd service to run the bot at start time (after the start of pe-orchestration-services).
Finally in clones the master (stable) branch of the bot from https://github.com/ncorrare/pe-slack-bot in /opt/pe-slack-bot. You can specify a $version variable upon classification to fix it to a specific tag.

### Limitations
This bot has only been tested in Centos 7, but it should work with most of the certified PE Master operating systems (that use systemd). I'll try to extend the testing to other platforms, and possibly add backwards compatibility to init.d.

### Development
Send a PR to either the Puppet module or the bot. I haven't had time to write unit tests yet, but they'll be added shortly. Travis is used for CI so every PR is automatically tested. Upon merging, a new release of the module will be pushed to the forge.
