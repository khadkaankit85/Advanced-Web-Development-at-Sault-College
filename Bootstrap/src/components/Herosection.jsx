
function HeroSection() {
    return (
        <section
            id="hero-section"
            className="d-flex align-items-center justify-content-center vh-100 text-white text-center"
            style={{
                backgroundImage: "url('https://via.placeholder.com/1920x1080')",
                backgroundSize: "cover",
                backgroundPosition: "center",
            }}
        >
            <div>
                <h1>Welcome to My Portfolio</h1>
                <p>This is a beautiful hero section with a background image.</p>
            </div>
        </section>
    );
}

export default HeroSection;
