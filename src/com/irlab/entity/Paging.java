package com.irlab.entity;

/**
 * @author   fangrongfu
 * @version  1.0
 * @Date     2017年8月14日上午10:01:01
 */
public class Paging {
	private String n_name;//  公司的名称  
	private String n_code;//  公司的股票代码
	private String n_event;//  公司的公告分类的类型
	private int    n_total;//  公司表根据名称、代码、公告类型查询的总条数
	private int    n_start;//  起始条数
	private int    n_rows;//   每一行的记录数
	public String getN_name() {
		return n_name;
	}
	public void setN_name(String n_name) {
		this.n_name = n_name;
	}
	public String getN_code() {
		return n_code;
	}
	public void setN_code(String n_code) {
		this.n_code = n_code;
	}
	public String getN_event() {
		return n_event;
	}
	public void setN_event(String n_event) {
		this.n_event = n_event;
	}
	public int getN_total() {
		return n_total;
	}
	public void setN_total(int n_total) {
		this.n_total = n_total;
	}
	public int getN_start() {
		return n_start;
	}
	public void setN_start(int n_start) {
		this.n_start = n_start;
	}
	public int getN_rows() {
		return n_rows;
	}
	public void setN_rows(int n_rows) {
		this.n_rows = n_rows;
	}
	@Override
	public String toString() {
		return "Paging [n_name=" + n_name + ", n_code=" + n_code + ", n_event=" + n_event + ", n_total=" + n_total
				+ ", n_start=" + n_start + ", n_rows=" + n_rows + "]";
	}
}
