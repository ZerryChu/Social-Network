package group.zerry.api_server.service;

import group.zerry.api_server.entity.Label;

public interface LabelService {
	public Label[] showHeatedLabel();
	
	public Label[] showRecommendedLabels(String username);

}
