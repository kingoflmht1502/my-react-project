import React from "react";
import Layout from "../components/layout/Layout";
import { Container } from "react-bootstrap";
import "../styles/Profile.scss";
import ProfileAside from "../components/profile/ProfileAside";
import ProfileMain from "../components/profile/ProfileMain";
import { useDispatch, useSelector } from "react-redux";
import { authActions } from "../redux/authSlice";
import { useNavigate } from "react-router-dom";

const Profile = () => {
	const user = useSelector((state) => state.auth.user);
	const dispatch = useDispatch();
	const navigate = useNavigate();
	const handleLogOut = () => {
		dispatch(authActions.logout());
	};
	const handleGoBack = () => {
		navigate(-1);
	};
	return (
		<Layout>
			<Container fluid style={{ padding: 0 }}>
				<div>
					<button onClick={handleGoBack}>&lt;- Back</button>
				</div>
				<div className="profile__container">
					<ProfileAside
						name={user.full_name}
						handleLogOut={handleLogOut}
					/>
					<ProfileMain user={user} />
				</div>
			</Container>
		</Layout>
	);
};

export default Profile;
