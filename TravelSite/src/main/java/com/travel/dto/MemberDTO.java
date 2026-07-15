package com.travel.dto;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberDTO {
	private int memberId;
	private String userId;
	private String password;
	private String name;
	private String email;
	private Date joinDate;
	private String isAdmin;
}
