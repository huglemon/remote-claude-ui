# 用官方 Node 20，兼容性好一点
FROM node:20-bullseye

# 装一些基础工具（git / bash 都要有）
RUN apt-get update && \
    apt-get install -y --no-install-recommends git ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# 安装 Claude Code CLI（官方推荐 npm 全局装）
# 参考：npm install -g @anthropic-ai/claude-code :contentReference[oaicite:0]{index=0}
RUN npm install -g @anthropic-ai/claude-code

# 安装 cc-model-switcher（cc_switch）
# 参考：npm install -g cc-model-switcher :contentReference[oaicite:1]{index=1}
RUN npm install -g cc-model-switcher

# 安装 Claude Code UI（提供 Web 界面）
# 参考：npm install -g @siteboon/claude-code-ui :contentReference[oaicite:2]{index=2}
RUN npm install -g @siteboon/claude-code-ui

# 准备 Claude Code & 项目目录
ENV CLAUDE_HOME=/root/.claude
RUN mkdir -p $CLAUDE_HOME/projects /workspace

WORKDIR /workspace

# 默认端口 3001，也可以在 Dokploy 里改 PORT 环境变量
ENV PORT=3001
EXPOSE 3001

# 默认就启动 Claude Code UI
CMD ["claude-code-ui"]