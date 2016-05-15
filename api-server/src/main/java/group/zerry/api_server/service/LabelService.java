package group.zerry.api_server.service;

import java.util.List;

import group.zerry.api_server.entity.Label;

public interface LabelService {
	public Label[] showHeatedLabel();
	
	public Label[] showRecommendedLabels(String username);

	public void addLabels(int msg_id, List<String> labels);
	
	public String[] showSimilarLabels(int label_id);
}
