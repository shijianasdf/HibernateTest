package beans;

public class student {
    private String id;//自定义主键名
    private String sex;
    private String name;
   
    private int score;
    private String university;
    public student(){
    	
    }
    
	public student(String name, int score) {//装载取得部分字段数据
		this.name = name;
		this.score = score;
	}

	public student(String sex, String name, int score, String university) {
		//this.id = id;
		this.name = name;
		this.sex = sex;
		this.score = score;
		this.university = university;
	}

	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getUniversity() {
		return university;
	}

	public void setUniversity(String university) {
		this.university = university;
	}
	
    
}
