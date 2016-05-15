package group.zerry.api_server.utils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.digester.plugins.strategies.FinderSetProperties;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.junit.Test;

import com.sun.tools.internal.xjc.reader.gbind.ElementSets;

class Node {
	public String name;
	public double value;
	public Node[] next;
} // 标签决策树节点

class words {
	public String name;
	public int level;
	public double value;
} // 待筛选关键字

// 标签自动识别
public class LabelManageTools {
	private Node rootNode;
	
	public LabelManageTools() {
		// TODO Auto-generated constructor stub
		try {
			init();
		} catch (DocumentException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// 标签树读入内存
	public void init() throws DocumentException {

		SAXReader reader = new SAXReader();
		File file = new File("/Users/zhuzirui/GitHub/Social-Network/api-server/src/main/resources/label_tree.xml");
		Document document = reader.read(file);
		Element root = document.getRootElement();
		List<Element> childElements = root.elements();
		rootNode = new Node();
		rootNode.value = 1;
		rootNode.next = new Node[childElements.size()];
		for (int i = 0;i < childElements.size(); i++) {
			List<Element> labels = childElements.get(i).elements();
			// 递归拓展决策树
			build_tree(rootNode, labels, i);
		}
	}

	private void build_tree(Node node, List<Element> childElements, int pos) {
		node.next[pos] = new Node();
		node.next[pos].name = childElements.get(0).getText();
		// value = 父节点value * value
		node.next[pos].value = Double.parseDouble(childElements.get(1).getText()) * node.value;
		node.next[pos].next = new Node[childElements.size()-2];
		for (int i = 2; i < childElements.size(); i++) {
			build_tree(node.next[pos], childElements.get(i).elements(), i-2);
		}
	}

	public List<String> recommentLabel(String label) {
		Node keyNode = null;
		if ((keyNode = findNode(rootNode, label, null)) != null) {
			List<String> list = new ArrayList<String>();
			for (int i = 0;i < keyNode.next.length; i++) {
				String name = keyNode.next[i].name;
				if (name.equals(label) == false)
					list.add(name);
			}
			if (list.size() < 5 && keyNode.name != null)
				list.add(keyNode.name);
			return list;
		} else
			return null;
	}

	public List<String> extractLabel(String content) {
		// 待筛选的关键字
		List<String> labels = new ArrayList<String>();
		List<String> keywords = com.hankcs.hanlp.HanLP.extractKeyword(content, 10);
		for (String keyword : keywords) {
			Node keyNode = null;
			if ((keyNode = findNode(rootNode, keyword, labels)) != null) {
				// 已获取标签
			}
		}
		return labels;
	}

	// DFS
	public Node findNode(Node _node, String keyword, List<String> labels) {
		Node node = null;
		for (int i = 0; i < _node.next.length; i++) {
			node = _node.next[i];
			if (keyword.contains(node.name)) {
				if (labels != null)
					labels.add(node.name); // 将标签加入到labels
				return _node;
				//return node;
			} else {
				Node result = null;
				if ((result = (findNode(node, keyword, labels))) != null)
					return result;
			}
		}
		return null;
	}

}
