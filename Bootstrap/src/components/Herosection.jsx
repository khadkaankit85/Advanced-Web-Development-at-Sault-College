const HeroSection = () => {
  return (
    <section
      id="hero"
      className="d-flex justify-content-center align-items-center text-center text-black"
      style={{
        backgroundImage:
          "url('https://images.unsplash.com/photo-1518002054494-3a6f94352e9d?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D')",
        backgroundSize: "cover",
        backgroundPosition: "center",
        height: "100vh",
      }}
    >
      <div className="container">
        <h1 className="text-white ">Welcome to Nepal</h1>
      </div>
    </section>
  );
};

export default HeroSection;
