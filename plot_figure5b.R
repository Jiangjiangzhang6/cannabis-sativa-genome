library(treeio)
library(ggtree)
library(ggnewscale)
library(RColorBrewer)
library(dplyr)
# Install the tidyverse package
library("tidyverse")
# --- 1. 读取树和注释数据 ---
tree <- read.tree("all_cbda.aln.treefile")
anno <- read.delim("itol.txt", header=TRUE, stringsAsFactors=FALSE)
colnames(anno)[1] <- "ID"   # 确保第一列名为 ID

# --- 2. 创建辅助逻辑列，用于筛选 jj == "cbdas" ---
# 假设注释表里，jj 列就是 cbdas 或者 "." 等
anno$isCbdas <- anno$jj == "cbdas"

# --- 3. 准备配色 ---
wf_lv <- unique(anno$wf)
yb_lv <- unique(anno$yb)
wf_pal <- setNames(brewer.pal(length(wf_lv), "Set1"), wf_lv)
yb_pal <- setNames(brewer.pal(length(yb_lv), "Set2"), yb_lv)

# --- 4. 绘制圆形主树，分支按 wf 着色 ---
p <- ggtree(tree, 
            layout="circular",
            aes(color = wf),
            size = 0.9) %<+% anno +
     scale_color_manual(name="wf", values = wf_pal) +
     theme(legend.position="right")

# --- 5. 外圈热图：yb ---
p <- gheatmap(p,
              anno %>% select(ID, yb) %>% column_to_rownames("ID"),
              offset = 0.02,
              width  = 0.05,
              colnames = FALSE,
              color = NA) +
     scale_fill_manual(name="yb", values = yb_pal) +
     new_scale_fill()

# --- 6. 最外层：在 isCbdas == TRUE 的叶尖加红色三角 ---
p <- p + 
     geom_tippoint(aes(subset = isCbdas),
                   shape = 17,    # 17 = 三角
                   color = "red",
                   size  = 2)
p

```




```{r}
library(ape)
library(cowplot)
tree <- read.tree("all_cbda.aln.treefile")
anno <- read.delim("itol.txt", header=TRUE, stringsAsFactors=FALSE)
colnames(anno)[1] <- "ID"

# 2. 标记 cbdas
anno <- anno %>% mutate(isCbdas = (jj == "cbdas"))

# 3. 配色
wf_lv  <- unique(anno$wf)
yb_lv  <- unique(anno$yb)
wf_pal <- setNames(brewer.pal(length(wf_lv), "Set1"), wf_lv)
yb_pal <- setNames(brewer.pal(length(yb_lv), "Set2"), yb_lv)

# 4. 主图（圆形）—— 分枝 wf 着色
p_main <- ggtree(tree,
                 layout="circular",
                 aes(color=wf),
                 size=0.6) %<+% anno +
  scale_color_manual(name="wf", values=wf_pal) +
  theme(legend.position="right")

# 5. 第一环（yb 热图）—— 注意这里用 gheatmap(p_main, …)
p_main <- gheatmap(p_main,
                   anno %>% select(ID, yb) %>% column_to_rownames("ID"),
                   offset   = 0.02,
                   width    = 0.10,
                   colnames = FALSE,
                   color    = NA) +
  scale_fill_manual(name="yb", values=yb_pal) +
  new_scale_fill()

# 6. cbdas 三角
p_main <- p_main +
  geom_tippoint(aes(subset=isCbdas),
                shape=17,
                color="red",
                size=1.3) +
  labs(title="CBDAS Family: Full Tree")

# 7. 提取 cbdas clade 子树
tips_cbdas <- anno$ID[anno$isCbdas]
mrca_node  <- getMRCA(tree, tips_cbdas)
subtree     <- extract.clade(tree, mrca_node)

# 8. 构造子树注释表——所有子树 tips 的 wf + isCbdas，ID 重命名为 label
anno_sub <- anno %>%
  filter(ID %in% subtree$tip.label) %>%
  select(ID, wf, isCbdas) %>%
  rename(label=ID)

# 9. 子树图（矩形），分枝 wf 着色 + cbdas 三角
p_sub <- ggtree(subtree,
                layout="rectangular",
                aes(color=wf),
                size=0.6) %<+% anno_sub +
  scale_color_manual(name="wf", values=wf_pal) +
  geom_tippoint(aes(subset=isCbdas),
                shape=17, color="red", size=1) +
  geom_tiplab(aes(label=label), size=2, align=TRUE) +
  theme_tree2() +
  labs(title="Zoom: cbdas clade")

# 10. 合并并导出
final <- ggdraw() +
  draw_plot(p_main, 0.00, 0.00, 1.00, 1.00) +
  draw_plot(p_sub,  0.60, 0.60, 0.35, 0.35)
final
```






```{r}
anno_sub <- anno %>%
  # 只留 cbdas clade 的 tips
  filter(ID %in% subtree$tip.label) %>%
  # 同时保留 wf、yb 和 isCbdas
  select(ID, wf, yb, isCbdas) %>%
  # 重命名 ID 列为 label 供 ggtree 识别
  rename(label = ID)

# —— 9. 绘制子树（矩形），分枝 wf 着色 + cbdas 三角 + 叶名 —— 
p_sub <- ggtree(subtree,
                layout="rectangular",
                aes(color=wf),
                size=0.6) %<+% anno_sub +
  scale_color_manual(name="wf", values=wf_pal) +
  # cbdas 叶尖红三角
  geom_tippoint(aes(subset = isCbdas),
                shape = 17, color = "red", size = 2) +
  # 叶名
  geom_tiplab(aes(label = label),
              size = 2, align = TRUE) +
  theme_tree2() +
  labs(title = "Zoom: cbdas clade")

# —— 10. 在子树外再加一层 yb 热图 —— 
p_sub <- gheatmap(p_sub,
                  # 用 label->行名，yb 作为填充
                  anno_sub %>% select(label, yb) %>% column_to_rownames("label"),
                  offset   = 0.02,
                  width    = 0.10,
                  colnames = FALSE,
                  color    = NA) +
  scale_fill_manual(name = "yb", values = yb_pal) +
  new_scale_fill()

# —— 11. 合并主图和子树并导出 —— 
final <- ggdraw() +
  draw_plot(p_main, 0.00, 0.00, 1.00, 1.00) +
  draw_plot(p_sub,  0.75, 0.55, 0.25, 0.25)
