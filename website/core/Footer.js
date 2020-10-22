/**
 * Copyright (c) 2017-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

const React = require('react');

class Footer extends React.Component {
  docUrl(doc, language) {
    const baseUrl = this.props.config.baseUrl;
    return `${baseUrl}docs/${language ? `${language}/` : ''}${doc}`;
  }

  pageUrl(doc, language) {
    const baseUrl = this.props.config.baseUrl;
    return baseUrl + (language ? `${language}/` : '') + doc;
  }

  render() {
    return (
      <footer className="nav-footer" id="footer">
        <section className="sitemap">
          <a href={this.props.config.baseUrl} className="nav-home">
            {this.props.config.footerIcon && (
              <img
                src={this.props.config.baseUrl + this.props.config.footerIcon}
                alt={this.props.config.title}
                width="66"
                height="58"
              />
            )}
          </a>
          <div>
            <h5>Docs</h5>
            <a href={this.docUrl('1-getting-started/Overview.html', this.props.language)}>
              Getting Started
            </a>
            <a href="https://www.iostabc.com/" target="_blank">
              Explorer1
            </a>
            <a href="https://explorer.iost.io/" target="_blank">
              Explorer2
            </a>
            <a href="https://iost.io/updates/" target="_blank">
              News
            </a>
            <a href="https://iost.io/resources/" target="_blank">
              Resources
            </a>
          </div>
          <div>
            <h5>Community</h5>
            {/* <a href={this.pageUrl('users.html', this.props.language)}>
              User Showcase
            </a> */}
            <a href="https://t.me/iostdev">Telegram Developer Group</a>
            <a href="https://medium.com/@iostoken">Medium</a>
            
            {/* <a href={`${this.props.config.baseUrl}blog`}>Blog</a> */}
          </div>
          <div>
            <h5>Social</h5>
            <div className="social">
              <a
                className="github-button"
                href={this.props.config.repoUrl}
                data-icon="octicon-star"
                data-count-href="/facebook/docusaurus/stargazers"
                data-show-count="true"
                data-count-aria-label="# stargazers on GitHub"
                aria-label="Star this project on GitHub">
                iost-official
              </a>
            </div>
            <div className="social">
              <a
                href={`https://twitter.com/${this.props.config.twitterUsername}`}
                className="twitter-follow-button">
                Follow @{this.props.config.twitterUsername}
              </a>
            </div>
          </div>
        </section>
        <section className="copyright">{this.props.config.copyright}</section>
      </footer>
    );
  }
}

module.exports = Footer;
